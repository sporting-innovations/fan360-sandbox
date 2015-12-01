//
//  Event.h
//  SIHomework
//
//  Created by Joe DeCapo on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>

// Model class for representing Events
@interface Event : NSObject

@property (strong, nonatomic) NSString *primaryName;
@property (strong, nonatomic) NSString *secondaryName;
@property (strong, nonatomic) NSString *eventDescription;
@property (strong, nonatomic) NSDate *startDateTime;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithJSONObject:(NSDictionary *)dict;

@end
