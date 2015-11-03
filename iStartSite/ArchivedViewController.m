//
//  ArchivedMessagesViewController.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.22..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "ArchivedViewController.h"

#import "ArchiveEditorViewController.h"
#import "ArchiveDetailViewController.h"
#import "ArchiveCell.h"

#import "Archive.h"
#import "Company+Format.h"
#import "Person+Format.h"
#import "Employee.h"
#import "MailboxMessage.h"
#import "NSDate+FormattedStrings.h"

@interface ArchivedViewController () < UITableViewDelegate, NSFetchedResultsControllerDelegate, MCSwipeTableViewCellDelegate >

@end

@implementation ArchivedViewController
{
    NSFetchedResultsController* fetchedResultsController;
    
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
    
    [self fetchedResultsController].delegate = self;
    [fetchedResultsController performFetch:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArchiveCell";
    ArchiveCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[ArchiveCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // Remove inset of iOS 7 separators.
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        // Setting the background color of the cell.
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    // Configuring the views and colors.
    UIView *checkView = [self viewWithImageName:@"check"];
    UIColor *greenColor = [UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    
    UIView *crossView = [self viewWithImageName:@"cross"];
    UIColor *redColor = [UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];
    
    // Setting the default inactive state color to the tableView background color.
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    Archive* archive = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    NSString* formattedCompany = [self getFormattedCompany:archive];
    NSString *formattedPerson = [self getFormattedPerson:archive];
    NSString* formattedOrderNr = @"Unknown order";
    
    cell.companyLabel.text = formattedCompany;
    cell.personLabel.text = formattedPerson;
    cell.orderNrLabel.text = formattedOrderNr;
    
    cell.archivedAtLabel.text = [archive.archivedAt dateStringWithFormat:@"MMM d"];
    
    MailboxMessage* message = archive.message;
    cell.subjectLabel.text = message.subject;
    
    // For the delegate callback
    [cell setDelegate:self];
    
    // Adding gestures per state basis.
    [cell setSwipeGestureWithView:checkView color:greenColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        
        NSLog(@"Did swipe \"Checkmark\" cell");
        [self swipeTableViewCell:cell didTriggerState:state withMode:mode];
        
    }];
    
    [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        
        NSLog(@"Did swipe \"Cross\" cell");
        [self swipeTableViewCell:cell didTriggerState:state withMode:mode];
        
    }];

    
    
    
    return cell;
}

- (NSString *)getFormattedCompany:(Archive *)archive
{
    NSString* formattedCompany;
    if (archive.company) {
        formattedCompany = [archive.company formattedCompanyName];
    } else {
        formattedCompany = @"Unknown company";
    }
    return formattedCompany;
}


- (NSString *)getFormattedPerson:(Archive *)archive
{
    NSString* formattedPerson;
    if (archive.company) {
        formattedPerson = [archive.employee.person formattedPersonName];
    } else {
        formattedPerson = @"Unknown person";
    }
    return formattedPerson;
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

#pragma mark - seques

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ArchiveDetailViewSegue"]) {
        
        NSIndexPath* selectedPath = [self.tableView indexPathForSelectedRow];
        
        ArchiveDetailViewController* vc = segue.destinationViewController;
        vc.archive = [[self fetchedResultsController] objectAtIndexPath:selectedPath];
        
    }
}

#pragma mark - NSFetchedResultsController - delegate

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"archiveStatus == %d", ArchiveStatusArchived];
    fetchedResultsController = [Archive MR_fetchAllGroupedBy:@"message.folder.name"
                                            withPredicate:predicate
                                                 sortedBy:@"message.uid"
                                                ascending:NO
                                                 delegate:self
                                                inContext:[NSManagedObjectContext MR_defaultContext]];
    return fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
        } break;
        case NSFetchedResultsChangeDelete: {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
        } break;
        case NSFetchedResultsChangeUpdate: {
            [tableView cellForRowAtIndexPath:indexPath];
        } break;
        case NSFetchedResultsChangeMove: {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
        } break;
    }
    
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
        } break;
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
        } break;
        default: {
            DDLogCError(@"Unhanlded case state in ArchivedViewController! type=%u", type);
        } break;
    }
}

#pragma mark - SwipeTableViewCell

- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didTriggerState:(MCSwipeTableViewCellState)state withMode:(MCSwipeTableViewCellMode)mode
{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    
    Archive* archive = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    if (mode == MCSwipeTableViewCellModeExit) {
        switch (state) {
            case MCSwipeTableViewCellState1:
                archive.archiveStatus = [NSNumber numberWithInt:ArchiveStatusArchived];
                archive.archivedAt = [NSDate date];
                break;
            default:
            case MCSwipeTableViewCellState3:
                archive.archiveStatus = [NSNumber numberWithInt:ArchiveStatusRejected];
                archive.archivedAt = nil;
                break;
        }
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    
    NSLog(@"IndexPath : %@ - MCSwipeTableViewCellState : %u - MCSwipeTableViewCellMode : %u", indexPath, state, mode);
    
}

#pragma mark - Utils

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}


- (IBAction)actionArchiveEmails:(id)sender {
}



@end
