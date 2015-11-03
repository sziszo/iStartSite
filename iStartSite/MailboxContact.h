//
//  MailboxContact.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, MailboxMessage;

@interface MailboxContact : NSManagedObject

@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) Contact *contact;
@property (nonatomic, retain) NSSet *receivedMessages;
@property (nonatomic, retain) NSSet *sentMessages;
@end

@interface MailboxContact (CoreDataGeneratedAccessors)

- (void)addReceivedMessagesObject:(MailboxMessage *)value;
- (void)removeReceivedMessagesObject:(MailboxMessage *)value;
- (void)addReceivedMessages:(NSSet *)values;
- (void)removeReceivedMessages:(NSSet *)values;

- (void)addSentMessagesObject:(MailboxMessage *)value;
- (void)removeSentMessagesObject:(MailboxMessage *)value;
- (void)addSentMessages:(NSSet *)values;
- (void)removeSentMessages:(NSSet *)values;

@end
