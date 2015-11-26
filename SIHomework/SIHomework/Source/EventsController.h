//
//  NetworkRequestController.h
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EventsControllerDelegate <NSObject>

- (void)updateEvents;

@end

@interface EventsController : NSObject

@property (weak, nonatomic) id<EventsControllerDelegate> delegate;
@property (strong, atomic) NSMutableArray *events;

- (void)fetchEventList;

@end
