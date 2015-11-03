//
//  MailboxSync.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.05..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "MailboxSynchronizer.h"

#import <MailCore/MCOIMAPSession.h>
#import <MailCore/MCOIMAPFolder.h>
#import <MailCore/MCOIMAPOperation.h>
#import <MailCore/MCOIMAPFetchFoldersOperation.h>

#import "Mailbox.h"
#import "MailboxFolder.h"
#import "MailboxMessage.h"
#import "MailboxContact.h"
#import "MailboxFolderWorker.h"
#import "MailboxMessageArchiver.h"

@interface MailboxSynchronizer ()

@property MCOIMAPSession* mailboxAccount;

@property (strong, atomic) NSNumber* workerNum;

@end

@implementation MailboxSynchronizer {
    
    dispatch_queue_t syncQueue;
    
    NSOperationQueue* folderWorkerQueue;
    
}

@synthesize mailboxAccount;
@synthesize workerNum;

- (id)init {
    if (self = [super init]) {
        syncQueue = dispatch_queue_create("sync queue", NULL);
    }
    return self;
}

- (void)syncWithCompletition:(void (^)(void))completition {
    if (!folderWorkerQueue) {
        folderWorkerQueue = [NSOperationQueue new];
    }
    
    dispatch_async(syncQueue, ^{
    
        if (!mailboxAccount) {
            [self connect];
        }
        
        
        MCOIMAPFetchFoldersOperation* foldersOperation = [mailboxAccount fetchSubscribedFoldersOperation];
        [foldersOperation start:^(NSError * error, NSArray * folders) {
            
            NSLog(@"All folders for session %@", folders);
            
            
            NSMutableArray* folderNames = [[NSMutableArray alloc] initWithCapacity:folders.count];
            for (MCOIMAPFolder *imapFolder in folders) {
                [folderNames addObject:imapFolder.path];
            }

            
            NSSet *subscribedFolders = [NSSet setWithArray:folderNames];
            
            NSSet* subFolders = [subscribedFolders filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"NOT( SELF BEGINSWITH[cd] %@ )", @"[Gmail]"]];
            
            workerNum = [NSNumber numberWithUnsignedInteger:[subFolders count]];
            
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                
                Mailbox* account = [Mailbox MR_findFirstByAttribute:@"loginName" withValue:self.account.loginName inContext:localContext];
                for (NSString* folderName in subFolders) {
                    MailboxFolder* folder = [MailboxFolder MR_findFirstByAttribute:@"name" withValue:folderName];
                    if (!folder) {
                        NSLog(@"save %@ folder to account", folderName);
                        
                        folder = [MailboxFolder MR_createInContext:localContext];
                        folder.name = folderName;
                        [account addFoldersObject:folder];
                    }
                }
                
            } completion:^(BOOL success, NSError *error) {
                
                for (NSString* folderName in subFolders) {
                    MailboxFolderWorker* folderWorker = [MailboxFolderWorker new];
                    folderWorker.folderName = folderName;
                    folderWorker.mailboxAccount = mailboxAccount;
                    
                    folderWorker.completionBlock = ^(void) {
                        @synchronized(self) {
                            workerNum = [NSNumber numberWithInt:workerNum.intValue - 1];
                            NSLog(@"folderWorker is completted! remains = %@ ", workerNum);
                            if ( workerNum.intValue <= 0) {
                                
                                if (completition) {
                                    completition();
                                }
                            }
                        }
                    };
                    
                    folderWorker.messageProcessor = ^(NSSet* messages, NSManagedObjectContext* localContext) {
                        MailboxMessageArchiver* messageArchiver = [[MailboxMessageArchiver alloc] initWithContext:localContext];
                        [messageArchiver archiveIncomingMessages:messages];
                    };
                    
                    [folderWorkerQueue addOperation:folderWorker];
                }
            }];
        }];
        
    });

}

- (BOOL)isStillSyncing {
    return workerNum.intValue > 0;
}

- (void)connect {
    if (!mailboxAccount) {
        if (self.account) {
            mailboxAccount = [self connectToAccount:self.account];
            NSLog(@"Successfully connected to %@", self.account.accountName);
        } else {
            NSLog(@"Could not connect because the account is missing");
        }
    }
}

- (MCOIMAPSession *)connectToAccount:(Mailbox *)account {
    if (!account) {
        NSLog(@"Could not connect to the account because the parameter account is nil");
        return nil;
    }
    
    NSString* loginName = account.loginName;
    
    NSLog(@"connecting to the %@ email account ", loginName);
    
    MCOIMAPSession *session = [[MCOIMAPSession alloc] init];
    [session setHostname:account.server];
    [session setPort:[account.port intValue]];
    [session setUsername:account.loginName];
    [session setPassword:account.password];
    [session setConnectionType:MCOConnectionTypeTLS];
    
    __block BOOL success = TRUE;
    
    MCOIMAPOperation * op = [session checkAccountOperation];
    [op start:^(NSError * error) {
        success = FALSE;
        NSLog(@"connecting to the account is failed %@", error);
    }];
    
    if (!success) {
        return nil;
    }
        
    NSLog(@"successfull connecting to %@ the account!!!!! :)))))", loginName);
    return session;
}

- (void)printFolders {
    if (!mailboxAccount) {
        [self connect];
    }
    
    MCOIMAPFetchFoldersOperation* foldersOperation = [mailboxAccount fetchSubscribedFoldersOperation];
    [foldersOperation start:^(NSError * error, NSArray * folders) {
        
        NSLog(@"Subscribed folders for session %@", folders);
        
    }];
}


@end
