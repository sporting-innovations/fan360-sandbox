//
//  NetworkRequestController.h
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EventFetchDelegate <NSObject>

- (void)updateEvents:(NSArray *)events;

@end

@interface NetworkRequestController : NSObject

@property (weak, nonatomic) id<EventFetchDelegate> delegate;

- (void)fetchEventList;

@end
