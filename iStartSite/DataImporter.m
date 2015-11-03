//
//  DataImporter.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.09..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "DataImporter.h"

#import "Person.h"
#import "User.h"
#import "Company.h"
#import "Contact.h"
#import "ContactEmail.h"
#import "Employee.h"

#import "ApplicationSettings.h"


@interface DataImporter ()



@end

@implementation DataImporter {
    BOOL _imported;
    
    float _progress;
    NSString* _progressText;
    BOOL _running;
    NSDate* _lastRunningDate;
}

static DataImporter* dataImporter;

+ (DataImporter *)sharedDataImporter {
    if ( !dataImporter ) {
        dataImporter = [[DataImporter alloc] init];
    }
    return dataImporter;    
}

- (float)getProgressValue {
    return _progress;
}

- (NSString *)getProgressText {
    return _progressText;
}

- (BOOL) isRunnning {
    return _running;
}

- (NSDate *)getLastRunningDate {
    return _lastRunningDate;
}

- (void)clear {
    _progress = 0;
    _progressText = @"";
}

- (void)import {
    _running = YES;
    
    _imported = [[ApplicationSettings sharedApplicationSettings] isDatabaseImported];
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        _progress = 0.0;
        _progressText = @"loading users";
        [self refreshDataImporterUIProgress:_progress withDetailText:_progressText];
        
        [self loadUsers:localContext];
        
        _progress = 0.25;
        _progressText = @"loading persons";
        [self refreshDataImporterUIProgress:_progress withDetailText:_progressText];
        
        [self loadPersons:localContext];
        
        _progress = 0.50;
        _progressText = @"loading companies";
        [self refreshDataImporterUIProgress:_progress withDetailText:_progressText];
        
        [self loadCompanies:localContext];
        
        _progress = 0.75;
        _progressText = @"loading employees";
        [self refreshDataImporterUIProgress:_progress withDetailText:_progressText];
        
        [self loadEmployees:localContext];
        
    } completion:^(BOOL success, NSError *error) {
        _running = NO;
        _progress = 1;
        _progressText = @"Finished";
        _lastRunningDate = [NSDate date];
        [self refreshDataImporterUIProgress:_progress withDetailText:_progressText];
        
        [self.dataImporterUI dataImportDidFinish];
        
        if (error) {
            NSLog(@"%@", [error description]);
            return;
        }
        [[ApplicationSettings sharedApplicationSettings] setDatabaseImported:YES];
        
//        NSArray* persons = [Person findAll];
//        for (Person* person in persons) {
//            NSLog(@"personId = %@, userName = %@", person.personId, person.user.userName);
//        }
    }];
    

}

- (void)refreshDataImporterUIProgress:(float)progress withDetailText:(NSString *)detailText{
    [self.dataImporterUI refreshDataImporterProgressView:progress withDetailText:detailText];
}


- (void)loadUsers:(NSManagedObjectContext* )localContext {

    NSArray* users = [self loadDataFromJsonFile:@"users"];
    
    for (NSDictionary *row in users) {
        
        User* user = _imported ? [User MR_findFirstByAttribute:@"userName" withValue:row[@"userName"] inContext:localContext] : nil;
        if ( !user ) {
            user     = [User MR_createInContext:localContext];
            [user MR_importValuesForKeysWithObject:row];
            NSLog(@"import user %@", user.userName);
        }
    }

}

- (void)loadPersons:(NSManagedObjectContext *)localContext {
    
    NSArray* persons = [self loadDataFromJsonFile:@"persons"];
    
    for (NSDictionary *obj in persons) {
        
        NSNumber* personId = obj[@"personId"];
        
        NSLog(@"importing person with personId %@ is started", personId);

        Person *person =  _imported ? [Person MR_findFirstByAttribute:@"personId" withValue:personId inContext:localContext] : nil;
        if ( !person ) {
            NSLog(@"create person with personId %@", personId);
            person     = [Person MR_createInContext:localContext];
        }
        
        [person MR_importValuesForKeysWithObject:obj];
        
        NSString* logname = obj[@"logname"];
        if (logname) {
            
            User* user = [self loadUserByUserName:logname inContext:localContext];
                        
            if ( ![person.user.userName isEqualToString:logname] ) {
                NSLog(@"set user %@ to person %@", logname, personId);
                person.user = user;
            }
        }
        
        NSLog(@"importing person with personId %@ is finished", person.personId);
    }
}

- (void)loadCompanies:(NSManagedObjectContext *)localContext {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];

    
    NSArray* companies = [self loadDataFromJsonFile:@"companies"];
    
    for (NSDictionary *obj in companies) {
        NSNumber* companyId = obj[@"companyId"];
        
//        if ( [companyId isEqualToNumber:[NSNumber numberWithLongLong:1119865910812]] ) {
//            NSLog(@"Got it!");
//        }
        
        NSLog(@"importing company with companyId %@ is started", companyId);
        
        Company* company = _imported ? [Company MR_findFirstByAttribute:@"companyId" withValue:companyId inContext:localContext] : nil;
        if ( !company ) {
            company = [Company MR_createInContext:localContext];
            company.companyId = companyId;
        }
        
        company.name1 = obj[@"name1"];
        company.name2 = obj[@"name2"];
        company.name3 = obj[@"name3"];
        company.name4 = obj[@"name4"];
        company.shortName = obj[@"shortName"];
        company.created = [formatter dateFromString: obj[@"created"] ];
        company.modified = [formatter dateFromString: obj[@"modified"] ];
        
        
        NSString* creator = obj[@"creator"];
        if (creator) {
            User* user = [self loadUserByUserName:creator inContext:localContext];
            if (![company.creator.userName isEqualToString:creator]) {
                company.creator = user;
            }
        }
        
        NSString* modifier = obj[@"modifier"];
        if (modifier) {
            User* user = [self loadUserByUserName:modifier inContext:localContext];
            if (![company.modifier.userName isEqualToString:modifier]) {
                company.modifier = user;
            }
        }
        
        Contact* contact = [Contact MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"company.companyId == %@", companyId] inContext:localContext];
        if (!contact) {
            contact = [Contact MR_createInContext:localContext];
            contact.company = company;
        }
        
        
        NSArray* emails = obj[@"emails"];
        for (NSString* email in emails) {
                        
            NSSet* resultContactEmails = [contact.emails filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"email == %@", email]];
            if ([resultContactEmails count] == 0) {
                
                ContactEmail* contactEmail = [ContactEmail MR_createInContext:localContext];
                contactEmail.email = email;
                contactEmail.contact = contact;
            }
        }
        
        NSLog(@"importing company with companyId %@ is finished", companyId);
                
    }
}

- (void)loadEmployees:(NSManagedObjectContext *)localContext {
    
    NSArray* employees = [self loadDataFromJsonFile:@"employees"];
    
    for (NSDictionary *obj in employees) {
        NSNumber* employeeId = obj[@"employeeId"];
        NSNumber* companyId = obj[@"companyId"];
        
        if (ddLogLevel == LOG_LEVEL_VERBOSE) {
            DDLogVerbose(@"Importing employee with employeeId %@ of companyId %@ is started", employeeId, companyId);
        }

        
        Employee* employee = _imported ? [Employee MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"company.companyId == %@ AND employeeId == %@ ",companyId, employeeId ] inContext:localContext] : nil;
        if (!employee) {
            employee = [Employee MR_createInContext:localContext];
            employee.employeeId = employeeId;
        }
        
        
        Company* company = [self loadCompanyByCompanyId:companyId inContext:localContext];
        if (employee.company.companyId != company.companyId) {
            employee.company = company;
        }
        
        NSNumber* personId = obj[@"personId"];        
        Person* person = [self loadPersonByPersonId:personId inContext:localContext];
        if (employee.person.personId != person.personId) {
            employee.person = person;
        }
        
        Contact* contact = [Contact MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"employee.employeeId == %@", employeeId] inContext:localContext];
        if (!contact) {
            contact = [Contact MR_createInContext:localContext];
            contact.employee = employee;
        }
        
        
        NSArray* emails = obj[@"emails"];
        for (NSString* email in emails) {
            
            NSSet* resultContactEmails = [contact.emails filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"email == %@", email]];
            if ([resultContactEmails count] == 0) {
                
                ContactEmail* contactEmail = [ContactEmail MR_createInContext:localContext];
                contactEmail.email = email;
                contactEmail.contact = contact;
            }
        }
        
        if (ddLogLevel == LOG_LEVEL_VERBOSE) {
            DDLogVerbose(@"Importing employee with employeeId %@ of companyId %@ is finished", employeeId, companyId);
        }


    }
}

- (Company *)loadCompanyByCompanyId:(NSNumber *)companyId inContext:(NSManagedObjectContext *)localContext  {
    
    Company* company = [Company MR_findFirstByAttribute:@"companyId" withValue:companyId inContext:localContext];
    if (!company) {
        NSLog(@"creating company by companyId %@", companyId);
        company = [Company MR_createInContext:localContext];
        company.companyId = companyId;
    }
    
    return company;
}

- (Person *)loadPersonByPersonId:(NSNumber *)personId inContext:(NSManagedObjectContext *)localContext {
    
    Person* person = [Person MR_findFirstByAttribute:@"personId" withValue:personId inContext:localContext];
    if (!person) {
        NSLog(@"creating person by personId %@", personId);
        person = [Person MR_createInContext:localContext];
        person.personId = personId;
    }
    
    return person;
    
}


- (User *)loadUserByUserName:(NSString *)username inContext:(NSManagedObjectContext *)localContext {
    
    User* user = [User MR_findFirstByAttribute:@"userName" withValue:username inContext:localContext];
    if (!user) {
        NSLog(@"creating user by logname %@", username);
        user = [User MR_createInContext:localContext];
        user.userName = username;
    }
    
    return user;
}

- (NSArray *)loadDataFromJsonFile:(NSString *)filename {
    NSError* err        = nil;
    NSString* dataPath  = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    
    NSData* contentData = [NSData dataWithContentsOfFile:dataPath];
    //        NSLog(@"Data : %@", contentData);
    
    //        NSLog(@"%@", [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding]);
    
    
    NSArray* data    = [NSJSONSerialization JSONObjectWithData:contentData
                                                          options:kNilOptions
                                                            error:&err];
    
    if (err) {
        NSLog(@"%@", err);
        return nil;
    }
    
    return data;

}

@end
