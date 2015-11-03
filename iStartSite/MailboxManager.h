//
//  EmailProvider.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.04.27..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Mailbox;

@interface MailboxManager : NSObject

@property (strong, nonatomic) Mailbox* account;

- (id)initWithAccount:(Mailbox *)account;

- (void)refreshMessages;
- (void)refreshMessagesWithCompletition:(void (^)(void))completition;

@end
