//
//  PersonReport.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.29..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "PersonReport.h"

#import "Person.h"

@implementation PersonReport

#pragma mark - Content filter

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    [_content removeAllObjects];
    
    NSArray* persons = [Person MR_findAllSortedBy:@"name1"
                                        ascending:YES
                                    withPredicate:[NSPredicate predicateWithFormat:@"name1 contains[c] %@", searchText]];
    _content = [NSMutableArray arrayWithArray:persons];
}


@end
