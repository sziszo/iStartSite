//
//  DataImporter.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.09..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataImporterUI.h"

@interface DataImporter : NSObject

@property (nonatomic, weak) id<DataImporterUI> dataImporterUI;

@property (readonly, getter = isRunning ) BOOL running;
@property (readonly, getter = getProgressValue) float progressValue;
@property (readonly, getter = getProgressText) NSString* _progressText;
@property (readonly, getter = getLastRunningDate) NSDate* _lastRunningDate;

#pragma mark - methods

+ (DataImporter *)sharedDataImporter;

- (void)import;
- (void)clear;

- (float)getProgressValue;
- (NSString *)getProgressText;

- (BOOL) isRunnning;
- (NSDate *)getLastRunningDate;

@end
