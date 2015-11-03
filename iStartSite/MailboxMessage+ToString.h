//
//  MailboxMessage+ToString.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.05..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MailboxMessage.h"

@interface MailboxMessage (ToString)

- (NSString *)toStringSenders;
- (NSString *)toStringReceivers;

@end
