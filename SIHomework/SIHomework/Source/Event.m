//
//  Event.m
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import "Event.h"

@implementation Event

- (instancetype)initWithJSONObject:(NSDictionary *)dict {
    self.primaryName = dict[@"primaryName"][@"en-US"];
    self.secondaryName = dict[@"secondaryName"][@"en-US"];
    self.eventDescription = dict[@"description"][@"en-US"];
    self.startDate = dict[@"startDate"];
    self.startDateTime = dict[@"startDateTime"];
    
    return self;
}

@end
