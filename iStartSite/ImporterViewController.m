//
//  DataImporterViewController.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.09..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "ImporterViewController.h"

#import <ECSlidingViewController/ECSlidingViewController.h>

#import "SettingsViewController.h"

#import "DataImporter.h"
#import "DataImporterUI.h"
#import "NSDate+FormattedStrings.h"
#import "ApplicationSettings.h"



@interface ImporterViewController () <DataImporterUI>

@property (weak, nonatomic) IBOutlet UIProgressView *databaseProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *emailProgressView;
@property (weak, nonatomic) IBOutlet UILabel *databaseImportDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailImportDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *databaseImportButton;

@end

@implementation ImporterViewController
{
    ApplicationSettings* applicationSettings;
}

@synthesize dataImportCompletition;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        applicationSettings = [ApplicationSettings sharedApplicationSettings];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.databaseProgressView.progress = 0;
    self.emailProgressView.progress = 0;
    
    self.databaseImportDetailLabel.text = @"";
    self.emailImportDetailLabel.text = @"";
                
    if (![applicationSettings isDatabaseImported]) {
        self.databaseImportButton.titleLabel.text = @"Import database";
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    
    DataImporter* dataImporter = [DataImporter sharedDataImporter];
    dataImporter.dataImporterUI = self;
    
    
    float progress = dataImporter.progressValue;
    NSString* progressText = dataImporter._progressText;
    if ([progressText length] == 0 ) {
        progressText = [self getImportedOn:dataImporter._lastRunningDate];
    }
    [self refreshDataImporterProgressView:progress withDetailText:progressText];
    

    if (![applicationSettings isDatabaseImported]) {
        if( progress > 0 ) {
            self.databaseImportButton.titleLabel.text = @"Stop database import";
        } else {
            self.databaseImportButton.titleLabel.text = @"Import database";
        }
    } else {
        if( progress > 0 ) {
            self.databaseImportButton.titleLabel.text = @"Stop database synchronization";
        } else {
            self.databaseImportButton.titleLabel.text = @"Sync database";
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action methods

- (IBAction)actionImportDatabase:(id)sender {
    DataImporter* dataImporter = [DataImporter sharedDataImporter];
    
    if ([dataImporter isRunnning]) {
        NSLog(@"dataImporter is still running ... ");
        return;
    }
    
    dataImporter.dataImporterUI = self;
    [dataImporter import];

}

- (IBAction)actionImportEmails:(id)sender {
}


- (void)refreshDataImporterProgressView:(float)progress withDetailText:(NSString *)detailText {
    
    //refresh progressView
    if ( self.databaseProgressView.progress != progress) {
        [self performSelectorOnMainThread:@selector(updateDatabaseProgressView:) withObject:[NSNumber numberWithFloat:progress]  waitUntilDone:NO];
    }
    
    //refresh label text if it's different
    if ( ![self.databaseImportDetailLabel.text isEqualToString:detailText] ) {
        [self.databaseImportDetailLabel performSelectorOnMainThread:@selector(setText:) withObject:detailText waitUntilDone:NO];
    }
}

- (void)updateDatabaseProgressView:(NSNumber *)progress {
    self.databaseProgressView.progress = [progress floatValue];
}


- (void)dataImportDidFinish {
    NSLog(@"Importing the BIPO data has been finished!");
        
    
    if ( dataImportCompletition ) {
        NSLog(@" execute dataImportCompletition block");
        dataImportCompletition();
    }
    
    [self performSelector:@selector(initDataImport) withObject:nil afterDelay:1.0];
    

}

- (void)initDataImport {
    DataImporter* dataImporter = [DataImporter sharedDataImporter];
    [dataImporter clear];
    
    [self refreshDataImporterProgressView:0 withDetailText:[self getImportedOn:dataImporter._lastRunningDate]];
}

-(NSString *)getImportedOn:(NSDate *)date {
    if (!date) {
        return @"";
    }
    return [NSString stringWithFormat:@"Imported on %@", [date dateStringWithFormat:@"MMM d"]];
}


@end
