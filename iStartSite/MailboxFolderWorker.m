//
//  MailboxFolderWorker.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.05..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <MailCore/MCOIndexSet.h>
#import <MailCore/MCOIMAPFetchMessagesOperation.h>
#import <MailCore/MCOIMAPMessage.h>
#import <MailCore/MCOMessageHeader.h>
#import <MailCore/MCOIMAPMessageRenderingOperation.h>
#import <MailCore/MCOAddress.h>

#import "MailboxFolderWorker.h"
#import "MailboxFolder.h"
#import "MailboxContact.h"
#import "MailboxMessage.h"


@implementation MailboxFolderWorker

@synthesize folderName;
@synthesize mailboxAccount;
@synthesize messageProcessor;

- (void)main {
    @autoreleasepool {
        NSManagedObjectContext* localContext = [NSManagedObjectContext 	MR_contextForCurrentThread];
        
        NSLog(@"processing folder %@", folderName);
        MailboxFolder* folder = [MailboxFolder MR_findFirstByAttribute:@"name" withValue:folderName inContext:localContext];
        if (!folder) {
            NSLog(@" %@ mailboxFolder does not exists!!!", folderName);
            return;
        }
        
        
        MCOIndexSet *uids = [MCOIndexSet indexSetWithRange:MCORangeMake(1, UINT64_MAX)];

        MCOIMAPFetchMessagesOperation *fetchOperation = [mailboxAccount fetchMessagesOperationWithFolder:folderName requestKind:MCOIMAPMessagesRequestKindHeaders uids:uids];
        
        [fetchOperation start:^(NSError * error, NSArray * fetchedMessages, MCOIndexSet * vanishedMessages) {
            //We've finished downloading the messages!
            
            //Let's check if there was an error:
            if(error) {
                NSLog(@"Error downloading message headers:%@", error);
            }
            
            //And, let's print out the messages...
//            NSLog(@"The post man delivereth:%@", fetchedMessages);
            
            NSLog(@"fetched messages:");
            for (MCOIMAPMessage *mail in fetchedMessages) {
//                NSLog(@"%u: %@", [mail uid], [mail header]  );
                
                NSNumber* uid = [NSNumber numberWithInteger:mail.uid];
                MailboxMessage* message = [MailboxMessage MR_findFirstByAttribute:@"uid" withValue:uid inContext:localContext];
                
                if (message) {
                    NSLog(@"message has already been downloaded! uid = %@",uid );
                    continue;
                }
                
                MCOMessageHeader* header = [mail header];
                
                message = [MailboxMessage MR_createInContext:localContext];
                message.uid = uid;
                message.subject = header.subject;
                message.senderDate = header.receivedDate;
                
//                MCOIMAPMessageRenderingOperation *bodyOp = [mailboxAccount plainTextBodyRenderingOperationWithMessage:mail folder:folderName];
//                
//                [bodyOp start:^(NSString * plainTextBodyString, NSError * error) {
//                    message.content = plainTextBodyString;
//                }];
                
                
                MCOAddress* from = [header from];
                
                MailboxContact* mailboxContact = [MailboxContact MR_findFirstByAttribute:@"emailAddress" withValue:from.mailbox inContext:localContext];
                
                if (!mailboxContact) {
                    mailboxContact = [MailboxContact MR_createInContext:localContext];
                    mailboxContact.emailAddress = from.mailbox;
                    mailboxContact.displayName = from.displayName;
                }
                [mailboxContact addSentMessagesObject:message];

                for (MCOAddress* receiver in header.to) {
                    
                    MailboxContact* mailboxContact = [MailboxContact MR_findFirstByAttribute:@"emailAddress" withValue:receiver.mailbox inContext:localContext];
                    
                    if (!mailboxContact) {
                        mailboxContact = [MailboxContact MR_createInContext:localContext];
                        mailboxContact.emailAddress = receiver.mailbox;
                        mailboxContact.displayName = receiver.displayName;
                    }
                    [mailboxContact addReceivedMessagesObject:message];
                }
                
                for (MCOAddress* receiver in header.cc) {
                    
                    MailboxContact* mailboxContact = [MailboxContact MR_findFirstByAttribute:@"emailAddress" withValue:receiver.mailbox inContext:localContext];
                    
                    if (!mailboxContact) {
                        mailboxContact = [MailboxContact MR_createInContext:localContext];
                        mailboxContact.emailAddress = receiver.mailbox;
                        mailboxContact.displayName = receiver.displayName;
                    }
                    [mailboxContact addReceivedMessagesObject:message];
                }
                
                for (MCOAddress* receiver in header.bcc) {
                    
                    MailboxContact* mailboxContact = [MailboxContact MR_findFirstByAttribute:@"emailAddress" withValue:receiver.mailbox inContext:localContext];
                    
                    if (!mailboxContact) {
                        mailboxContact = [MailboxContact MR_createInContext:localContext];
                        mailboxContact.emailAddress = receiver.mailbox;
                        mailboxContact.displayName = receiver.displayName;
                    }
                    [mailboxContact addReceivedMessagesObject:message];
                }
                message.folder = folder;
            }
        }];
        
        [localContext MR_saveToPersistentStoreAndWait];
        
        if (messageProcessor) {
            messageProcessor(folder.messages, localContext);
        }
        
        [localContext MR_saveToPersistentStoreAndWait];
        
        /*
        NSArray* emails = [[mailboxAccount folderWithPath:folderName] messagesFromSequenceNumber:1 to:0 withFetchAttributes:CTFetchAttrEnvelope];
        NSLog(@"emails amount = %d", [emails count]);
        for (CTCoreMessage* mail in emails) {
            
            NSNumber* uid = [NSNumber numberWithInteger:mail.uid];
            MailboxMessage* message = [MailboxMessage findFirstByAttribute:@"uid" withValue:uid inContext:localContext];
            
            if (message) {
                NSLog(@"message has already been downloaded! uid = %@",uid );
                continue;
            }
            
            message = [MailboxMessage createInContext:localContext];
            message.uid = uid;
            message.subject = mail.subject;
            message.senderDate = mail.senderDate;
            message.content = mail.body;
            
            for (CTCoreAddress* sender in mail.from) {
                MailboxContact* mailboxContact = [MailboxContact findFirstByAttribute:@"emailAddress" withValue:sender.email inContext:localContext];
                if (!mailboxContact) {
                    mailboxContact = [MailboxContact createInContext:localContext];
                    mailboxContact.emailAddress = sender.email;
                    mailboxContact.displayName = sender.name;
                }
                [mailboxContact addSentMessagesObject:message];
                
            }
            for (CTCoreAddress* receiver in mail.to) {
                MailboxContact* mailboxContact = [MailboxContact findFirstByAttribute:@"emailAddress" withValue:receiver.email inContext:localContext];
                if (!mailboxContact) {
                    mailboxContact = [MailboxContact createInContext:localContext];
                    mailboxContact.emailAddress = receiver.email;
                    mailboxContact.displayName = receiver.name;
                }
                [mailboxContact addReceivedMessagesObject:message];
            }
            message.folder = folder;
        }
                
        [localContext saveToPersistentStoreAndWait];
        
        if (messageProcessor) {
            messageProcessor(folder.messages, localContext);
        }
        
        [localContext saveToPersistentStoreAndWait];
        */
    }
}


@end
