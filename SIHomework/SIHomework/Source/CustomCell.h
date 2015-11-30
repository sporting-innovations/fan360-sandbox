//
//  CustomCellTableViewCell.h
//  SportingInnovations
//
//  Created by Ryan Peters on 11/28/15.
//  Copyright © 2015 Savvy Edge Technologies, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *primaryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryNameLabel;

@end
