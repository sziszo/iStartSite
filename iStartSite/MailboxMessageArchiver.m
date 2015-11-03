//
//  MailboxMessageArchiver.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.20..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "MailboxMessageArchiver.h"

#import "MailboxMessage.h"
#import "MailboxContact+ToString.h"

#import "Archive.h"
#import "Company+Format.h"
#import "Project.h"
#import "User.h"
#import "Contact.h"
#import "ContactEmail.h"
#import "Employee.h"
#import "Person+Format.h"


@implementation MailboxMessageArchiver {
    NSManagedObjectContext* _context;
}

- (id)initWithContext:(NSManagedObjectContext *)context {
    if (self = [super init]) {
        _context = context;
    }
    return self;
}


- (void):(NSSet *)messages  {
    
    if (ddLogLevel == LOG_LEVEL_VERBOSE) {
        DDLogVerbose(@"archiving messages is started ...");
    }

    for (MailboxMessage* message in messages) {
        
        Archive* archive = message.archiveInfo;
        if (!archive) {
            archive = [Archive MR_createInContext:_context];
            archive.message = message;
            archive.archiveStatus = [NSNumber numberWithInt:ArchiveStatusNotSet];            
        }
        
        int archivedStatus = archive.archiveStatus.intValue;
        if (archivedStatus == ArchiveStatusArchived || archivedStatus == ArchiveStatusRejected) {
            
            if (ddLogLevel == LOG_LEVEL_VERBOSE) {
                NSString* archivedStatusString = [self createArchivedStatusString:archivedStatus];
                DDLogVerbose(@"Message[id=%d] %@!", message.uid.intValue, archivedStatusString );
            }
            continue;
            
        }
        
        for (MailboxContact* sender in message.senders) {
            
            Contact* contact = [self loadContactFromMailboxContact:sender];
            
            if (contact) {
                
                Employee* employee = contact.employee;
                if (!employee && contact.person) {
                    employee = [[contact.person.employes allObjects] objectAtIndex:0];
                }
                
                if (employee) {
                    archive.company = employee.company;
                    archive.employee = employee;
                } else if (contact.company) {
                    archive.company = contact.company;
                }
                
            }
        }
        
        for (MailboxContact* receiver in message.receivers) {
            
            Contact* contact = [self loadContactFromMailboxContact:receiver];
            
            if (contact) {
                Person* person = contact.person;
                if (!person && contact.employee) {
                    person = contact.employee.person;
                }
                
                archive.creator = person.user;
            }
        }
        
        //TODO looking for the project number in the message subject ( and in the message body )
        
    }
}

- (NSString *)createArchivedStatusString:(int)archivedStatus {
    NSString* archivedStatusString = @"";
    switch (archivedStatus) {
        case ArchiveStatusArchived:
            archivedStatusString = @"has already been archived";
            break;
        case ArchiveStatusRejected:
            archivedStatusString = @"has already been rejected";
            break;
        default:
            archivedStatusString = @"is in unknown archive state";
            break;
    }
    return archivedStatusString;
}


- (Contact *)loadContactFromMailboxContact:(MailboxContact *)mailboxContact {
    
    Contact* contact = mailboxContact.contact;
    
    if (!contact) {
        if (ddLogLevel == LOG_LEVEL_VERBOSE) {
            DDLogVerbose(@"Searching bipo contact for sender %@", [mailboxContact toString]);
        }
        
        ContactEmail* contactEmail = [ContactEmail MR_findFirstByAttribute:@"email" withValue:mailboxContact.emailAddress inContext:_context];
        
        if (contactEmail) {
            contact = contactEmail.contact;
            mailboxContact.contact = contact;
            
            if (ddLogLevel == LOG_LEVEL_VERBOSE) {
                DDLogVerbose(@"found bipo contact for sender %@", [mailboxContact toString]);
            }
        }
    }
    
    return contact;
}

@end
