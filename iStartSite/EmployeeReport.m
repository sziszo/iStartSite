//
//  EmployeeReport.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.29..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "EmployeeReport.h"

#import "Employee.h"
#import "Person+Format.h"


@implementation EmployeeReport

#pragma mark - Content filter

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    [_content removeAllObjects];
    
    
    NSArray* employees = [Employee MR_findAllSortedBy:@"person.name1"
                                     ascending:YES
                                 withPredicate:[NSPredicate predicateWithFormat:@"person.name1 contains[c] %@", searchText]];
    _content = [NSMutableArray arrayWithArray:employees];
}


@end
