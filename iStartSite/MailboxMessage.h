//
//  MailboxMessage.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Archive, MailboxContact, MailboxFolder;

@interface MailboxMessage : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * senderDate;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) Archive *archiveInfo;
@property (nonatomic, retain) MailboxFolder *folder;
@property (nonatomic, retain) NSSet *receivers;
@property (nonatomic, retain) NSSet *senders;
@end

@interface MailboxMessage (CoreDataGeneratedAccessors)

- (void)addReceiversObject:(MailboxContact *)value;
- (void)removeReceiversObject:(MailboxContact *)value;
- (void)addReceivers:(NSSet *)values;
- (void)removeReceivers:(NSSet *)values;

- (void)addSendersObject:(MailboxContact *)value;
- (void)removeSendersObject:(MailboxContact *)value;
- (void)addSenders:(NSSet *)values;
- (void)removeSenders:(NSSet *)values;

@end
