//
//  TableViewController.m
//  SIHomework
//
//  Created by Ryan Peters on 11/29/15.
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"
#import "SIViewController.h"
#import "AFNetworking.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self makeRequestsFromServer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)makeRequestsFromServer{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters=@{@"token": requestToken};
    
    [manager GET:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.eventsFromServiceResource = [NSJSONSerialization JSONObjectWithData:responseObject options: NSJSONReadingMutableContainers error:nil];
        [self sortEventsByDate];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)sortEventsByDate{
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDateTime" ascending:TRUE];
    [self.eventsFromServiceResource sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.eventsFromServiceResource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CustomCell";
    
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDictionary *thisDict=[self.eventsFromServiceResource objectAtIndex:indexPath.row];
    
    cell.primaryNameLabel.text=[[thisDict objectForKey:@"primaryName"]objectForKey:@"en-US"];
    cell.secondaryNameLabel.text=[[thisDict objectForKey:@"secondaryName"]objectForKey:@"en-US"];
    cell.startDateAndTimeLabel.text=[self formatDateFromDateString:[thisDict objectForKey:@"startDateTime"]];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SIViewController *detailVC=[storyboard instantiateViewControllerWithIdentifier:@"SIViewController"];
    detailVC.eventDetailDict=[self.eventsFromServiceResource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
