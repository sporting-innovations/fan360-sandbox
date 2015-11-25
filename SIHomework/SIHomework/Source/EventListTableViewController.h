//
//  EventListTableViewController.h
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkRequestController.h"

@interface EventListTableViewController : UITableViewController <EventFetchDelegate>

@property (nonatomic, strong) NetworkRequestController *networkRequestController;
@property (nonatomic, strong) NSMutableArray *events;

@end
