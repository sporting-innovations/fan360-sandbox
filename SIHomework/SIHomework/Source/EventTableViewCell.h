//
//  EventTableViewCell.h
//  SIHomework
//
//  Created by goodle on 11/26/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *primaryTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;

@end
