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
    [dateFormat setDateFormat:@"MMM dd, h:mm a"];
    cell.dateLabel.text = [dateFormat stringFromDate:theEvent.startDateTime];
    cell.eventImageView.image = theEvent.image;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
