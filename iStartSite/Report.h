//
//  Report.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.29..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Report <NSObject>

#pragma mark - Properties 

- (NSArray *)content;

- (NSArray *)scopes;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;


#pragma mark - Content filter

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;

@end
