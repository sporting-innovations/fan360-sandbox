//
//  TableViewController.h
//  SIHomework
//
//  Created by Ryan Peters on 11/29/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>

#define requestURL @"https://raw.githubusercontent.com/sporting-innovations/fan360-sandbox/master/service/events.json"
#define requestImageURL @"https://raw.githubusercontent.com/sporting-innovations/fan360-sandbox/master/service/images/"
#define requestToken @"ABmsLgpyv3oHoovLMFnqkt-HUbSkmV0hks5WWMktwA%3D%3D"

@interface TableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *eventsFromServiceResource;

@end