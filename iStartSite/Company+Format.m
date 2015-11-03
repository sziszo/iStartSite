//
//  Company+ToString.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.20..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "Company+Format.h"

@implementation Company (Format)

- (NSString *)formattedCompanyName {
    
    NSMutableString* formattedCompanyName = [[NSMutableString alloc] init];
    
    if (self.name1) {
        [formattedCompanyName appendString:self.name1];
        [formattedCompanyName appendString:@" "];
    }
    
    if (self.name2) {
        [formattedCompanyName appendString:self.name2];
        [formattedCompanyName appendString:@" "];
    }
    
    if (self.name3) {
        [formattedCompanyName appendString:self.name3];
        [formattedCompanyName appendString:@" "];
    }
    
    if (self.name4) {
        [formattedCompanyName appendString:self.name4];
    }
    
    if (formattedCompanyName.length == 0) {
        [formattedCompanyName appendString:@"Unknown company name"];
    }
    
    return formattedCompanyName;
}

@end
