//
//  F3RMyProfileViewController.m
//  Pineapple
//
//  Created by user on 1/14/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RMyProfileViewController.h"
#import "AppDelegate.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "F3RNotificationTableViewCell.h"
#import "F3RNotification.h"
#import "F3RFacebookUser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "F3RCommentsViewController.h"
#import "F3RCoolNavi.h"

static CGFloat const kWindowHeight = 235.0f;
static NSUInteger const kCellNum = 40;
static NSUInteger const kRowHeight = 44;
static NSString * const kCellIdentify = @"cell";

@implementation F3RMyProfileViewController
{
    NSMutableArray *collection;
    NSDateFormatter *dateFormat;
    
    UITapGestureRecognizer *showDescriptionPostTap;
    UITapGestureRecognizer *updateFollowStatusPostTap;
    UITapGestureRecognizer *showCommentsPostTap;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    F3RCoolNavi *headerView = [[F3RCoolNavi alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kWindowHeight)backGroudImage:@"background" headerImageURL:@"http://d.hiphotos.baidu.com/image/pic/item/0ff41bd5ad6eddc4f263b0fc3adbb6fd52663334.jpg" title:@"妹子!" subTitle:@"个性签名, 啦啦啦!"];
    headerView.scrollView = self.tableView;
    headerView.imgActionBlock = ^(){
        NSLog(@"headerImageAction");
    };
    [self.view addSubview:headerView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;

    
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    
    //[self.tableView setDataSource:self];
    
  
    
    //[self.activityIndicator startAnimating];
    
 
    //[self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter and setter

/*
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentify];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

*/

#pragma mark - tableView Delegate and dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return kCellNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"test %ld",(long)indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}



/*

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
    static NSString * cellIdentifier = @"testTableViewCell";
    
    F3RNotificationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[F3RNotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    
    F3RNotification  *notification = [collection objectAtIndex:row];
    
    [cell.lblDescription setText:notification.descripcion];
    
    _cellHeader = cell;
    
    return cell;
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath
              atScrollPosition:(UITableViewScrollPosition)scrollPosition
                      animated:(BOOL)animated
{
    NSLog(@"scrollToRowAtIndexPath");
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Add some logic here to determine the section header. For example, use
    // indexPathsForVisibleRows to get the visible index paths, from which you
    // should be able to get the table view row that corresponds to the current
    // section header. How this works will be implementation dependent.
    //
    // If the current section header has changed since the pervious scroll request
    // (because a new one should now be at the top of the screen) then you should
    // update the contents.
    
    NSIndexPath *firstVisibleIndexPath = [[self.tableView indexPathsForVisibleRows] objectAtIndex:0];
    NSLog(@"first visible cell's section: %li", (long)firstVisibleIndexPath.section);
    F3RNotificationTableViewCell *headerCell = [self.tableView cellForRowAtIndexPath:firstVisibleIndexPath];
    
    // If it exists then it's on screen. Hide our false header
    
    if (headerCell)
        self.cellHeader.hidden = true;
    
    // If it doesn't exist (not on screen) or if it's partially scrolled off the top,
    // position our false header at the top of the screen
    
    if (!headerCell || headerCell.frame.origin.y < self.tableView.contentOffset.y )
    {
        self.cellHeader.hidden = NO;
        self.cellHeader.frame = CGRectMake(0, self.tableView.contentOffset.y, self.cellHeader.frame.size.width, self.cellHeader.frame.size.height);
    }
    
    // Make sure it's on top of all other cells
    
    [self.tableView bringSubviewToFront:self.cellHeader];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Click commentsFromNotification");
    
    
    if([[segue identifier] isEqualToString:@"commentsFromNotification"])
    {
        F3RCommentsViewController * view = [segue destinationViewController];
        
        NSIndexPath * myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath section];
        
        F3RNotification  *notification = [collection objectAtIndex:row];
        
        view.idPost = notification.idnoticia;
    }
    
}
 */

@end
