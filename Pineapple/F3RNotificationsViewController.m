//
//  F3RNotificationsViewController.m
//  Pineapple
//
//  Created by user on 1/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RNotificationsViewController.h"
#import "AppDelegate.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "F3RNotificationTableViewCell.h"
#import "F3RNotification.h"
#import "F3RFacebookUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation F3RNotificationsViewController
{
    NSMutableArray *collection;
    NSDateFormatter *dateFormat;
    
    UITapGestureRecognizer *showDescriptionPostTap;
    UITapGestureRecognizer *updateFollowStatusPostTap;
    UITapGestureRecognizer *showCommentsPostTap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    
    [self.tableView setDataSource:self];
    
    //[self.activityIndicator startAnimating];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) loadData
{
    collection = [[NSMutableArray alloc] init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    MSTable *table = [client tableWithName:@"notificacionusuario"];
    
    MSQuery *query = [table queryWithPredicate: [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"idusuario == %@",F3RFacebookUser.user.id]]];
    [query orderByDescending:@"__createdAt"];
    [query readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) {
            NSLog(@"ERROR %@", error);
        } else {
            for(NSDictionary *item in result.items) {
                
                F3RNotification *notification = [[F3RNotification alloc] init];
                
                for (NSString *key in item) {
                    
                    if ([notification respondsToSelector:NSSelectorFromString(key)]) {
                        
                        [notification setValue:[item valueForKey:key] forKey:key];
                    }
                    
                }
                
                [collection addObject:notification];

            }
            [self.tableView reloadData];
        }
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return collection.count;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return UITableViewAutomaticDimension;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"notificationTableViewCell";
    
    F3RNotificationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[F3RNotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    F3RNotification  *notification = [collection objectAtIndex:row];
    
    [cell.lblDescription setText:notification.descripcion];
    
    return cell;
}

@end
