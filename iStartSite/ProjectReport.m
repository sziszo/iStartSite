//
//  ProjectReport.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.29..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "ProjectReport.h"

#import "Project.h"


@implementation ProjectReport

#pragma mark - Content filter

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    [_content removeAllObjects];
    
    NSArray* projects = [Project MR_findAllSortedBy:@"name"
                                       ascending:YES
                                   withPredicate:[NSPredicate predicateWithFormat:@"name contains[c] %@", searchText]];
    _content = [NSMutableArray arrayWithArray:projects];
}


@end
