//
//  NetworkRequestController.m
//  SIHomework
//
//  Created by goodle on 11/25/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import "NetworkRequestController.h"
#import "AFNetworking/AFNetworking.h"

@implementation NetworkRequestController

- (void)fetchEventList {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = nil;
    NSDictionary *parameters = @{@"token": @"ABmsLgpyv3oHoovLMFnqkt-HUbSkmV0hks5WWMktwA%3D%3D"};
    [manager GET:@"https://raw.githubusercontent.com/sporting-innovations/fan360-sandbox/master/service/events.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
