//
//  Event.m
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import "Event.h"
#import "AFNetworking/AFNetworking.h"

@implementation Event

- (instancetype)initWithJSONObject:(NSDictionary *)dict {
    self.primaryName = dict[@"primaryName"][@"en-US"];
    self.secondaryName = dict[@"secondaryName"][@"en-US"];
    self.name = [NSString stringWithFormat:@"%@ - %@", self.primaryName, self.secondaryName];
    self.eventDescription = dict[@"description"][@"en-US"];
//    NSString *startDateString = dict[@"startDate"];
    NSString *startDateTimeString = dict[@"startDateTime"];

    NSString *dateSubstring = [startDateTimeString substringToIndex:[startDateTimeString length] - 5];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
    self.startDateTime = [dateFormat dateFromString:[dateSubstring stringByReplacingOccurrencesOfString:@"T" withString:@""]];
    
    return self;
}

@end
