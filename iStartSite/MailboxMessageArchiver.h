//
//  MailboxMessageArchiver.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.20..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MailboxMessageArchiver : NSObject

- (id)initWithContext:(NSManagedObjectContext *)context;

- (void)archiveIncomingMessages:(NSSet* )messages;

@end
