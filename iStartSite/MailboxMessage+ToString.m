//
//  MailboxMessage+ToString.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.05..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "MailboxMessage+ToString.h"
#import "MailboxContact+ToString.h"

@implementation MailboxMessage (ToString)


- (NSString *)toStringSenders {
    NSString* toString = @"";
    for (MailboxContact* contact in self.senders) {
        toString = [toString stringByAppendingString:[contact toString]];
    }
    return toString;
}

- (NSString *)toStringReceivers {
    NSString* toString = @"";
    for (MailboxContact* contact in self.receivers) {
        toString = [toString stringByAppendingString:[contact toString]];
    }
    return toString;
}


@end
