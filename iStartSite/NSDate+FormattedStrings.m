//
//  NSDate+FormattedStrings.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.05..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "NSDate+FormattedStrings.h"

@implementation NSDate (FormattedStrings)

- (NSString *)dateStringWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:style];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)dateStringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

@end
