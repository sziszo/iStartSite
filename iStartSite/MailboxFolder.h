//
//  MailboxFolder.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Mailbox, MailboxMessage;

@interface MailboxFolder : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Mailbox *mailbox;
@property (nonatomic, retain) NSSet *messages;
@end

@interface MailboxFolder (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(MailboxMessage *)value;
- (void)removeMessagesObject:(MailboxMessage *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
