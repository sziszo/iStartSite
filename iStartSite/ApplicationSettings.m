//
//  ApplicationSettings.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.13..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "ApplicationSettings.h"

static NSString *importedKey = @"imported";


@interface ApplicationSettings () {
    
}

@end


@implementation ApplicationSettings {
}

static ApplicationSettings *sharedApplicationSettings;

+ (ApplicationSettings *)sharedApplicationSettings {
    if ( !sharedApplicationSettings ) {
        sharedApplicationSettings = [[ApplicationSettings alloc] init];
    }
    return sharedApplicationSettings;
}

- (BOOL)isDatabaseImported {
    return [[NSUserDefaults standardUserDefaults] boolForKey:importedKey];    
}

- (void)setDatabaseImported:(BOOL)imported {
    [[NSUserDefaults standardUserDefaults] setBool:imported forKey:importedKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
