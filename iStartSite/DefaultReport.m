//
//  DefaultReport.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.29..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "DefaultReport.h"

@interface DefaultReport ()

@end

@implementation DefaultReport 

#pragma mark - Initialization

- (id)init {
    if (self = [super init] ) {
        _content = [NSMutableArray array];
    }
    return self;
}


#pragma mark - Properties

- (NSArray *)content {
    return _content;
}

- (NSArray *)scopes {
    return nil;
}

- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [_content count];
}


#pragma mark - Content filter

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    
}


@end
