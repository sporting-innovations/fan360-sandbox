//
//  NetworkRequests.m
//  SIHomework
//
//  Created by Mertin Curban Gazi on 24/11/2015.
//  Copyright (c) 2015 Sporting Innovations. All rights reserved.
//

#import "NetworkRequests.h"

@implementation NetworkRequests

NSString *base_url=@"https://raw.githubusercontent.com/sporting-innovations/fan360-sandbox/master/service/";

+ (void)executeMethod:(NSString*)method withBody:(NSData*)body withURL:(NSURL*)URL completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completionHandler
{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (body) {
        
        
        [urlRequest setHTTPBody: body];
    }
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask* dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          
                                          if (completionHandler == nil) return;
                                          
                                          if (error)
                                          {
                                              completionHandler(nil, response, error);
                                              return;
                                          }
                                          
                                          completionHandler(data, response, nil);
                                      }];
    [dataTask resume];
}


+ (void)search:(NSDictionary*)searchDict completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completionHandler
{
    NSURL* URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@events.json", base_url]];
    
    [self executeMethod:@"GET" withBody:nil withURL:URL completion:completionHandler];
}



@end
