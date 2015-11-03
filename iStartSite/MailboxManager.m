//
//  EmailProvider.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.04.27..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "MailboxManager.h"


#import "Mailbox.h"
#import "MailboxSynchronizer.h"

@implementation MailboxManager {
    
    MailboxSynchronizer* sync;
}

- (id)initWithAccount:(Mailbox *)account {
    if (self = [super init]) {
        self.account = account;
    }
    return self;
}

- (void)refreshMessages {
    [self refreshMessagesWithCompletition:nil];
}


- (void)refreshMessagesWithCompletition:(void (^)(void))completition {
    if(!self.account) {
        NSLog(@"Account is required!");
        return;
    }
    
    
    if (!sync) {
        sync = [[MailboxSynchronizer alloc] init];
        sync.account = self.account;
    }
    
    if( [sync isStillSyncing] ) {
        NSLog(@"The previous synchronization is still running .... ");
        return;
    }
    
    [sync syncWithCompletition:completition];
    
}


@end
