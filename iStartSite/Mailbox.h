//
//  Mailbox.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MailboxFolder;

@interface Mailbox : NSManagedObject

@property (nonatomic, retain) NSString * accountName;
@property (nonatomic, retain) NSDate * lastSyncDate;
@property (nonatomic, retain) NSString * loginName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * port;
@property (nonatomic, retain) NSString * server;
@property (nonatomic, retain) NSNumber * sslAuth;
@property (nonatomic, retain) NSSet *folders;
@end

@interface Mailbox (CoreDataGeneratedAccessors)

- (void)addFoldersObject:(MailboxFolder *)value;
- (void)removeFoldersObject:(MailboxFolder *)value;
- (void)addFolders:(NSSet *)values;
- (void)removeFolders:(NSSet *)values;

@end
