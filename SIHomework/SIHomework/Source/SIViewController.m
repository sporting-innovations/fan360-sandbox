//
//  ViewController.m
//
//  Copyright © 2015 Sporting Innovations. All rights reserved.
//

#import "SIViewController.h"

#import "NetworkRequests.h"

@interface SIViewController ()
@property (strong, nonatomic) NSMutableArray * arrResult;
@end

@implementation SIViewController
@synthesize arrResult;
- (void)viewDidLoad {
    [NetworkRequests search:nil completion:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         arrResult =    [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
         if (arrResult == nil)
             return;
         int len = arrResult.count;
         NSMutableArray *tempArr = [[NSMutableArray alloc] init];
         for (int i=0 ; i<len ; i++)
         {
             NSDictionary *tempDict = [arrResult objectAtIndex:i];
             [tempArr addObject: [tempDict valueForKey:@"startDateTime"]];
         }
         NSArray * temp;
         for (int i=0; i<len-1 ; i++)
             for (int j=i+1; j<len; j++)
             {
                 if ( [[tempArr objectAtIndex:i] caseInsensitiveCompare:[tempArr objectAtIndex:j]] == NSOrderedDescending)
                 {
                     temp = arrResult[i];
                     arrResult[i] = arrResult[j];
                     arrResult[j] = temp;
                 }
             }
         
         [self.tableView reloadData];
     }];

    [super viewDidLoad];
}

-(NSInteger )tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger) section

{
    return [arrResult count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    cell.contentView.backgroundColor = [UIColor darkGrayColor];
    UIView *content = [[UIView alloc]init];
    NSDictionary *dictResult = [arrResult objectAtIndex:indexPath.row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 200, 40)];
    label.text = [dictResult[@"primaryName"] valueForKey:@"en-US"];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, 200, 40)];
    label2.text = [dictResult valueForKey:@"startDateTime"];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(70, 100, 200, 40)];
    label3.text = [dictResult[@"primaryName"] valueForKey:@"en-US"];
    [content addSubview:label];
    [content addSubview:label2];
    [content addSubview:label3];
    [cell.contentView   addSubview:content];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


@end
