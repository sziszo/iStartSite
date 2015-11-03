//
//  ArchiveGroup.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Archive, Company, Project;

@interface ArchiveGroup : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *archive;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) Project *project;
@end

@interface ArchiveGroup (CoreDataGeneratedAccessors)

- (void)addArchiveObject:(Archive *)value;
- (void)removeArchiveObject:(Archive *)value;
- (void)addArchive:(NSSet *)values;
- (void)removeArchive:(NSSet *)values;

@end
