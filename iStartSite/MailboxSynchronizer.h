//
//  MailboxSync.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.05..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Mailbox;

@interface MailboxSynchronizer : NSObject

@property (strong, nonatomic) Mailbox* account;

- (void)syncWithCompletition:(void (^)(void))completition;

- (BOOL)isStillSyncing;

@end
