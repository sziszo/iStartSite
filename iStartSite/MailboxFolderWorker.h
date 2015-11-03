//
//  MailboxFolderWorker.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.05..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MailCore/MCOIMAPSession.h>

typedef void (^MessageProcessor)(NSSet* messages, NSManagedObjectContext* localContext);

@interface MailboxFolderWorker : NSOperation

@property (strong, nonatomic) NSString* folderName;
@property MCOIMAPSession* mailboxAccount;

@property (nonatomic, copy) MessageProcessor messageProcessor;

@end
