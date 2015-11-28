//
//  EventListTableViewController.m
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import "EventListTableViewController.h"
#import "EventTableViewCell.h"
#import "EventViewController.h"
#import "Event.h"

@interface EventListTableViewController ()

@end

@implementation EventListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventsController = [[EventsController alloc] init];
    self.eventsController.delegate = self;
    [self.eventsController fetchEventList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventsController.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventItem" forIndexPath:indexPath];
    
    // Configure the cell...
    Event *theEvent = self.eventsController.events[indexPath.row];
    cell.primaryTitleLabel.text = theEvent.primaryName;
    cell.secondaryTitleLabel.text = theEvent.secondaryName;
    cell.descriptionLabel.text = theEvent.eventDescription;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, HH:mm"];
    cell.dateLabel.text = [dateFormat stringFromDate:theEvent.startDateTime];
    cell.eventImageView.image = theEvent.image;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    EventViewController *vc = (EventViewController *)[segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    EventTableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    for (Event *event in self.eventsController.events) {
        if ([event.primaryName isEqualToString:selectedCell.primaryTitleLabel.text]) {
            vc.event = event;
        }
    }
}


#pragma mark - EventsControllerDelegate

- (void)updateEvents {
    [self.tableView reloadData];
}

@end
