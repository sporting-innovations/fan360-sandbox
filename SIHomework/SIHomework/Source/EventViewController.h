//
//  EventViewController.h
//  SIHomework
//
//  Created by goodle on 11/27/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventViewController : UIViewController

@property (strong, nonatomic) Event *event;

@property (weak, nonatomic) IBOutlet UILabel *primaryTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;

@end
