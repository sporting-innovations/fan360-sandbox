//
//  EventViewController.m
//  SIHomework
//
//  Created by goodle on 11/27/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.primaryTitleLabel.text = self.event.primaryName;
    self.secondaryTitleLabel.text = self.event.secondaryName;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, h:mm a"];
    self.dateLabel.text = [dateFormat stringFromDate:self.event.startDateTime];
    self.descriptionLabel.text = self.event.eventDescription;
    self.eventImageView.image = self.event.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
