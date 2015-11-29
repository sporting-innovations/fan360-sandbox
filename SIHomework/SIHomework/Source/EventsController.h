//
//  EventsController.h
//  SIHomework
//
//  Created by Joe DeCapo on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>

// Delegate protocol for Event update notifications
@protocol EventsControllerDelegate <NSObject>
- (void)updatedEvents;
@end

// Controller class for managing Events
@interface EventsController : NSObject

@property (weak, nonatomic) id<EventsControllerDelegate> delegate;
@property (strong, atomic) NSArray *events;

- (void)fetchEventList;

@end
