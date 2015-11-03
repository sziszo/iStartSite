//
//  CompanyReport.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.29..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "CompanyReport.h"

#import "Company+Format.h"


@implementation CompanyReport 


#pragma mark - Content filter

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    [_content removeAllObjects];
    
    NSArray* companies = [Company MR_findAllSortedBy:@"name1"
                                    ascending:YES
                                    withPredicate:[NSPredicate predicateWithFormat:@"name1 contains[c] %@", searchText]];
    _content = [NSMutableArray arrayWithArray:companies];
}


@end
