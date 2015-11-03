//
//  Employee.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Archive, Company, Contact, Person;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSNumber * employeeId;
@property (nonatomic, retain) Archive *archivingMessages;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) Person *person;
@end

@interface Employee (CoreDataGeneratedAccessors)

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

@end
