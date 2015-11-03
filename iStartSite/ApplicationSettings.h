//
//  ApplicationSettings.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.13..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationSettings : NSObject

+ (ApplicationSettings *)sharedApplicationSettings;

- (BOOL)isDatabaseImported;
- (void)setDatabaseImported:(BOOL)imported;

@end
