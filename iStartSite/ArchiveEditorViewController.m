//
//  ArchiveDetailViewController.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.02..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "ArchiveEditorViewController.h"

#import "ReportViewController.h"

#import "MailboxMessage+ToString.h"
#import "Archive.h"
#import "Company+Format.h"
#import "Employee.h"
#import "Person+Format.h"

@interface ArchiveEditorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectDesignation1Label;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *responsibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *visibleForLabel;
@property (weak, nonatomic) IBOutlet UISwitch *completedSwitch;

@end

@implementation ArchiveEditorViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
//        self.archivedAtLabel.text = [self.archive.archivedAt dateStringWithFormat:@"MMM d"];
        
        MailboxMessage* message = self.archive.message;
        if (message) {
            self.subjectLabel.text = message.subject;
            self.fromLabel.text = [message toStringSenders];
            self.toLabel.text = [message toStringReceivers];
            self.bodyLabel.text = message.content;
        }
        
    }    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"CompanyReportSegue"]) {
        
        ReportViewController* vc = segue.destinationViewController;
        vc.reportType = ReportTypeCompany;
        vc.reportValue = self.companyNameLabel.text;
        
    } else if ([segue.identifier isEqualToString:@"EmployeeReportSegue"]) {
        
        ReportViewController* vc = segue.destinationViewController;
        vc.reportType = ReportTypeEmployee;
        vc.reportValue = self.personNameLabel.text;
                          
    } else if ([segue.identifier isEqualToString:@"ProjectReportSegue"]) {
        
        ReportViewController* vc = segue.destinationViewController;
        vc.reportType = ReportTypeProject;
        vc.reportValue = self.projectNameLabel.text;
        
    } else if ([segue.identifier isEqualToString:@"ProjectDesigReportSegue"]) {
        
        ReportViewController* vc = segue.destinationViewController;
        vc.reportType = ReportTypeProject;
        vc.reportValue = self.projectDesignation1Label.text;
    }
}


#pragma mark - Navigation methods

- (IBAction)unwindToArchiveEditorViewController:(UIStoryboardSegue *)segue {
    
}

@end
