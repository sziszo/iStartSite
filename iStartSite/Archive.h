//
//  Archive.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ArchiveGroup, Company, Employee, MailboxMessage, Project, User;

@interface Archive : NSManagedObject

@property (nonatomic, retain) NSDate * archivedAt;
@property (nonatomic, retain) NSNumber * archiveId;
@property (nonatomic, retain) NSNumber * archiveStatus;
@property (nonatomic, retain) ArchiveGroup *archiveGroup;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) User *creator;
@property (nonatomic, retain) Employee *employee;
@property (nonatomic, retain) MailboxMessage *message;
@property (nonatomic, retain) Project *project;

@end
