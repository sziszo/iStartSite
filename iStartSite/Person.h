//
//  Person.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, Employee, User;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name1;
@property (nonatomic, retain) NSString * name2;
@property (nonatomic, retain) NSNumber * personId;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) NSSet *employes;
@property (nonatomic, retain) User *user;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

- (void)addEmployesObject:(Employee *)value;
- (void)removeEmployesObject:(Employee *)value;
- (void)addEmployes:(NSSet *)values;
- (void)removeEmployes:(NSSet *)values;

@end
