//
//  Contact.h
//  iStartSite
//
//  Created by Szilard Antal on 2015. 01. 02..
//  Copyright (c) 2015. Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company, ContactEmail, Employee, MailboxContact, Person;

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) NSSet *emails;
@property (nonatomic, retain) Employee *employee;
@property (nonatomic, retain) MailboxContact *mailboxContact;
@property (nonatomic, retain) Person *person;
@end

@interface Contact (CoreDataGeneratedAccessors)

- (void)addEmailsObject:(ContactEmail *)value;
- (void)removeEmailsObject:(ContactEmail *)value;
- (void)addEmails:(NSSet *)values;
- (void)removeEmails:(NSSet *)values;

@end
