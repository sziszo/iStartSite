//
//  Company.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Archive, ArchiveGroup, Contact, Employee, Project, User;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSNumber * companyId;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * history;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSString * name1;
@property (nonatomic, retain) NSString * name2;
@property (nonatomic, retain) NSString * name3;
@property (nonatomic, retain) NSString * name4;
@property (nonatomic, retain) NSString * shortName;
@property (nonatomic, retain) NSSet *archiveGroups;
@property (nonatomic, retain) NSSet *archivingMessages;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) User *creator;
@property (nonatomic, retain) NSSet *employes;
@property (nonatomic, retain) User *modifier;
@property (nonatomic, retain) NSSet *projects;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addArchiveGroupsObject:(ArchiveGroup *)value;
- (void)removeArchiveGroupsObject:(ArchiveGroup *)value;
- (void)addArchiveGroups:(NSSet *)values;
- (void)removeArchiveGroups:(NSSet *)values;

- (void)addArchivingMessagesObject:(Archive *)value;
- (void)removeArchivingMessagesObject:(Archive *)value;
- (void)addArchivingMessages:(NSSet *)values;
- (void)removeArchivingMessages:(NSSet *)values;

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

- (void)addEmployesObject:(Employee *)value;
- (void)removeEmployesObject:(Employee *)value;
- (void)addEmployes:(NSSet *)values;
- (void)removeEmployes:(NSSet *)values;

- (void)addProjectsObject:(Project *)value;
- (void)removeProjectsObject:(Project *)value;
- (void)addProjects:(NSSet *)values;
- (void)removeProjects:(NSSet *)values;

@end
