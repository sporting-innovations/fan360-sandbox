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
    self.startDate = dict[@"startDate"];
    self.startDateTime = dict[@"startDateTime"];
    
    NSArray *assets = dict[@"assets"];
    NSDictionary *imageInformation = assets[0];
    NSString *imageFileName = imageInformation[@"externalId"];
    NSString *imageContentType = imageInformation[@"contentType"];
    NSString *prefixToRemove = @"image/";
    NSString *imageFileType = [imageContentType copy];
    if ([imageContentType hasPrefix:prefixToRemove])
        imageFileType = [imageContentType substringFromIndex:[prefixToRemove length]];
    NSString *imageName = [NSString stringWithFormat:@"%@.%@", imageFileName, imageFileType];
    [self fetchImage:imageName];
    
    return self;
}

- (void)fetchImage:(NSString *)imageName {
    NSString *urlString = [NSString stringWithFormat:@"https://raw.githubusercontent.com/sporting-innovations/fan360-sandbox/master/service/images/%@", imageName];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.image = responseObject;
        NSLog(@"Response: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];
}

@end
