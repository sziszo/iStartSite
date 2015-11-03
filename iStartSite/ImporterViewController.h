//
//  DataImporterViewController.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.09..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Completition)(void);

@interface ImporterViewController : UITableViewController

@property (nonatomic, weak) Completition dataImportCompletition;

@end
