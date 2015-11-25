//
//  Event.h
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Event : NSObject

@property (strong, nonatomic) NSString *primaryName;
@property (strong, nonatomic) NSString *secondaryName;
@property (strong, nonatomic) NSString *eventDescription;
@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *startDateTime;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithJSONObject:(NSDictionary *)dict;

@end
