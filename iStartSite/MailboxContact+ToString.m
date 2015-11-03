//
//  MailboxContact+ToString.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.05..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "MailboxContact+ToString.h"

@implementation MailboxContact (ToString)

- (NSString *)toString {
    NSString* name = self.displayName;
    if ([name length] == 0) {
        name = self.emailAddress;
    }
    
    return [NSString stringWithFormat:@"%@", name ];
}

@end
