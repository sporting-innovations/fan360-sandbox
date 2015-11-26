//
//  EventListTableViewController.h
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsController.h"

@interface EventListTableViewController : UITableViewController <EventsControllerDelegate>

@property (nonatomic, strong) EventsController *eventsController;

@end
