//
//  DataImporterUI.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.09..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataImporterUI <NSObject>

- (void)refreshDataImporterProgressView:(float)progress withDetailText:(NSString *)detailText;

- (void)dataImportDidFinish;
@end
