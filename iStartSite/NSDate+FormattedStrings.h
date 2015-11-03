//
//  NSDate+FormattedStrings.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.05..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FormattedStrings)

- (NSString *)dateStringWithFormat:(NSString *)format;
- (NSString *)dateStringWithStyle:(NSDateFormatterStyle)style;

@end
