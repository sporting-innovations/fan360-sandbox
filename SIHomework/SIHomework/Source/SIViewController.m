//
//  ViewController.m
//
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import "SIViewController.h"
#import "TableViewController.h"
#import "UIImageView+AFNetworking.h"

@interface SIViewController ()

@end

@implementation SIViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.primaryNameLabel.text=[[self.eventDetailDict objectForKey:@"primaryName"]objectForKey:@"en-US"];
    self.secondaryNameLabel.text=[[self.eventDetailDict objectForKey:@"secondaryName"]objectForKey:@"en-US"];
    self.startDateAndTimeLabel.text=[self formatDateFromDateString:[self.eventDetailDict objectForKey:@"startDateTime"]];
    self.descriptionLabel.text=[[self.eventDetailDict objectForKey:@"description"]objectForKey:@"en-US"];
    
    [self downloadAndDisplayImage];
    
    
}






-(void)downloadAndDisplayImage{
    
    NSString *contentType=[[[self.eventDetailDict objectForKey:@"assets"] objectAtIndex:0]objectForKey:@"contentType"];
    if ([contentType isEqualToString:@"image/jpeg"])
    {
        contentType=@"jpeg";
    }
    else if ([contentType isEqualToString:@"image/png"])
    {
        contentType=@"png";
    }
    
    
    NSString *externalID=[[[self.eventDetailDict objectForKey:@"assets"]objectAtIndex:0]objectForKey:@"externalId"];
    
    [self.eventImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.%@?token=%@",requestImageURL,externalID,contentType,requestToken]]];
    
    self.eventImage.contentMode = UIViewContentModeScaleAspectFit;
    self.eventImage.layer.masksToBounds=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)formatDateFromDateString:(NSString *) dateString{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssxxx"];
    
    NSDate *date = [dateFormat dateFromString:dateString];
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    [newDateFormatter setDateFormat:@"MM/dd/yyyy h:mm a"];
    
    NSString *newDateString = [newDateFormatter stringFromDate:date];
    
    return newDateString;
}

@end