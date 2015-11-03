//
//  ReportViewController.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.28..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "ReportViewController.h"

#import "Report.h"
#import "ReportFactory.h"

#import "Company+Format.h"
#import "Person+Format.h"
#import "Employee.h"

static  NSString* DetailCellId = @"DetailCell";

static  NSString* CompanyHistoryCellId = @"CompanyHistoryCell";
static  NSString* PersonHistoryCellId = @"PersonHistoryCell";
static  NSString* ProjectHistoryCellId = @"ProjectHistoryCell";

static  NSString* CompanyReportCellId = @"CompanyReportCell";
static  NSString* PersonReportCellId = @"PersonReportCell";
static  NSString* ProjectReportCellId = @"ProjectReportCell";


@interface ReportViewController () <UISearchDisplayDelegate, UISearchBarDelegate>


@end

@implementation ReportViewController {
    
    id<Report> report;
    
}

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
    
    
//    self.searchDisplayController.searchBar.placeholder =
    
    
    report = [ReportFactory createReportByType:self.reportType];
    
    NSString* placeholder = @"";
    switch (self.reportType) {
        case ReportTypeCompany:
            placeholder = @"Searching company";
            break;
        case ReportTypeEmployee:
            placeholder = @"Searching employee";
            break;
        case ReportTypePerson:
            placeholder = @"Searching person";
            break;
        case ReportTypeProject:
            placeholder = @"Searching project";
            break;            
        default:
            break;
    }
    
    self.searchDisplayController.searchBar.placeholder = placeholder;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    int numberOfSections = 1;
    if (tableView == self.tableView) {
        numberOfSections = 1;
    } else {
        numberOfSections = [report numberOfSections];
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows = 1;
    if (tableView == self.tableView) {
        numberOfRows = 1;
    } else {
        numberOfRows = [report numberOfRowsInSection:section];
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    UITableViewCell *cell = nil;
    
    if (tableView == self.tableView) {
        
        if (indexPath.section == 0 ) {
            cellIdentifier = DetailCellId;
        } else {
            switch (self.reportType) {
                case ReportTypeCompany:
                    cellIdentifier = CompanyHistoryCellId;
                    break;
                case ReportTypeEmployee:
                case ReportTypePerson:
                    cellIdentifier = PersonHistoryCellId;
                    break;
                case ReportTypeProject:
                    cellIdentifier = ProjectHistoryCellId;
                    break;
            }
        }
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
    } else {
        UITableViewCellStyle cellStyle;
        
        switch (self.reportType) {
            case ReportTypeCompany:
                cellIdentifier = CompanyReportCellId;
                cellStyle = UITableViewCellStyleDefault;
                break;
            case ReportTypeEmployee:
            case ReportTypePerson:
                cellIdentifier = PersonReportCellId;
                cellStyle = UITableViewCellStyleSubtitle;
                break;
            case ReportTypeProject:
                cellIdentifier = ProjectReportCellId;
                cellStyle = UITableViewCellStyleSubtitle;
                break;
        }
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:cellIdentifier];
        }
    }
    
    // Configure the cell...
    
    if ([DetailCellId isEqualToString:cellIdentifier]) {
        cell.textLabel.text = self.reportValue;
    } else if ([CompanyReportCellId isEqualToString:cellIdentifier]) {
        
        Company* company = [[report content] objectAtIndex:indexPath.row];
        cell.textLabel.text = [company formattedCompanyName];
        
    } else if ([PersonReportCellId isEqualToString:cellIdentifier]) {
        Employee* employee = [[report content] objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [employee.person formattedPersonName];
        cell.detailTextLabel.text = [employee.company formattedCompanyName];
    }
    
    return cell;
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
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSString* selectedValue = nil;
        switch (self.reportType) {
            case ReportTypeCompany: {
                Company* company = [[report content] objectAtIndex:indexPath.row];
                selectedValue = [company formattedCompanyName];
                break;
            }
            case ReportTypeEmployee: {
                Employee* employee = [[report content] objectAtIndex:indexPath.row];
                selectedValue = [employee.person formattedPersonName];
                break;
            }
            default:
                break;
        }
        
        self.reportValue = selectedValue;
        [self.searchDisplayController setActive:NO animated:YES];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



#pragma mark - UISearchDisplayControllerDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
        
    NSString* scope = [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
    
    [report filterContentForSearchText:searchString scope:scope];
    
    return YES;
}


@end
