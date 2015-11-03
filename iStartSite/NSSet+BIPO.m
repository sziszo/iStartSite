//
//  NSSet+BIPO.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.03..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "NSSet+BIPO.h"

@implementation NSSet (BIPO)

- (NSString *)toString {
    NSString* toString = @"";
    for (NSObject* element in self) {
        toString = [toString stringByAppendingString:[NSString stringWithFormat:@"%@", element]];
    }
    return toString;
}

@end
