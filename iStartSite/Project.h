//
//  Project.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Archive, ArchiveGroup, Company, User;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * designation;
@property (nonatomic, retain) NSDate * history;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * projectNr;
@property (nonatomic, retain) NSString * projectType;
@property (nonatomic, retain) NSNumber * projectYear;
@property (nonatomic, retain) NSSet *archiveGroups;
@property (nonatomic, retain) NSSet *archivingMessages;
@property (nonatomic, retain) User *creator;
@property (nonatomic, retain) Company *customer;
@property (nonatomic, retain) User *modifier;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addArchiveGroupsObject:(ArchiveGroup *)value;
- (void)removeArchiveGroupsObject:(ArchiveGroup *)value;
- (void)addArchiveGroups:(NSSet *)values;
- (void)removeArchiveGroups:(NSSet *)values;

- (void)addArchivingMessagesObject:(Archive *)value;
- (void)removeArchivingMessagesObject:(Archive *)value;
- (void)addArchivingMessages:(NSSet *)values;
- (void)removeArchivingMessages:(NSSet *)values;

@end
