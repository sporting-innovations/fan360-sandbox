//
//  ViewController.h
//
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIViewController : UIViewController

@property (strong, nonatomic) NSDictionary *eventDetailDict;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *primaryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@end

