//
//  User.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Archive, Company, Person, Project;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *createdArchivingMessages;
@property (nonatomic, retain) NSSet *createdCompanies;
@property (nonatomic, retain) NSSet *createdProjects;
@property (nonatomic, retain) NSSet *modifiedCompanies;
@property (nonatomic, retain) NSSet *modifiedProjects;
@property (nonatomic, retain) Person *person;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCreatedArchivingMessagesObject:(Archive *)value;
- (void)removeCreatedArchivingMessagesObject:(Archive *)value;
- (void)addCreatedArchivingMessages:(NSSet *)values;
- (void)removeCreatedArchivingMessages:(NSSet *)values;

- (void)addCreatedCompaniesObject:(Company *)value;
- (void)removeCreatedCompaniesObject:(Company *)value;
- (void)addCreatedCompanies:(NSSet *)values;
- (void)removeCreatedCompanies:(NSSet *)values;

- (void)addCreatedProjectsObject:(Project *)value;
- (void)removeCreatedProjectsObject:(Project *)value;
- (void)addCreatedProjects:(NSSet *)values;
- (void)removeCreatedProjects:(NSSet *)values;

- (void)addModifiedCompaniesObject:(Company *)value;
- (void)removeModifiedCompaniesObject:(Company *)value;
- (void)addModifiedCompanies:(NSSet *)values;
- (void)removeModifiedCompanies:(NSSet *)values;

- (void)addModifiedProjectsObject:(Project *)value;
- (void)removeModifiedProjectsObject:(Project *)value;
- (void)addModifiedProjects:(NSSet *)values;
- (void)removeModifiedProjects:(NSSet *)values;

@end
