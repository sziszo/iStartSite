//
//  ArchiveDetailViewController.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.25..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "ArchiveDetailViewController.h"

#import "ArchiveEditorViewController.h"

#import "MailboxMessage+ToString.h"
#import "Company+Format.h"
#import "Employee.h"
#import "Person+Format.h"
#import "NSDate+FormattedStrings.h"

@interface ArchiveDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *designationLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNrLabel;
@property (weak, nonatomic) IBOutlet UILabel *responsibleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *archivedAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *sentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@end

@implementation ArchiveDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.archive) {
        
        NSString* formattedCompanyName = [self.archive.company formattedCompanyName];
        if (formattedCompanyName.length > 0 ) {
            self.companyNameLabel.text = formattedCompanyName;
            self.companyNameLabel.textColor = [UIColor blackColor];
        }
        
        NSString* formattedPersonName = [self.archive.employee.person formattedPersonName];
        if (formattedPersonName.length > 0 ) {
            self.personNameLabel.text = formattedPersonName;
            self.personNameLabel.textColor = [UIColor blackColor];
        }
        
        self.orderNrLabel.text = @"";
        self.designationLabel.text = @"";
        
        self.archivedAtLabel.text = [self.archive.archivedAt dateStringWithFormat:@"MMM d"];

        MailboxMessage* message = self.archive.message;
        if (message) {
            self.subjectLabel.text = message.subject;
            self.senderLabel.text = [message toStringSenders];
            self.bodyLabel.text = message.content;
            self.sentDateLabel.text = [message.senderDate dateStringWithFormat:@"MMM d"];
        }

    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ArchivEditorSegue"]) {
        
        ArchiveEditorViewController* vc = segue.destinationViewController;
        vc.archive = self.archive;
        
    }
}

#pragma mark - Navigation methods

- (IBAction)unwindToArchiveDetailViewController:(UIStoryboardSegue *)segue {
    
}


@end
