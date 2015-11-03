//
//  Person+Format.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.20..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "Person+Format.h"

@implementation Person (Format)

- (NSString *)formattedPersonName {
    return [NSString stringWithFormat:@"%@, %@", self.name1, self.name2 ];
}

@end
