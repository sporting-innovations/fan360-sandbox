//
//  NetworkRequests.h
//  SIHomework
//
//  Created by Mertin Curban Gazi on 24/11/2015.
//  Copyright (c) 2015 Sporting Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequests : NSObject
+ (void)search:(NSDictionary*)searchDict completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completionHandler;
@end
