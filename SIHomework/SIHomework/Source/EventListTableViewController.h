//
//  EventListTableViewController.h
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetworkRequestController;

@interface EventListTableViewController : UITableViewController

@property (nonatomic, strong) NetworkRequestController *networkRequestController;

@end
