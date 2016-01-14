//
//  F3RCommentsViewController.m
//  Pineapple
//
//  Created by user on 1/10/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RCommentsViewController.h"
#import "AppDelegate.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "F3RCommentTableViewCell.h"
#import "F3RCustomComment.h"
#import "F3RFacebookUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation F3RCommentsViewController
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
    
    NSDictionary *parameters = @{ @"idnew": _idPost };
    
    [client invokeAPI:@"comments_new_aux"
                 body:nil
           HTTPMethod:@"GET"
           parameters:parameters
              headers:nil
           completion:  ^(NSDictionary *result,
                          NSHTTPURLResponse *response,
                          NSError *error){
               if(error) { // error is nil if no error occured
                   NSLog(@"ERROR %@", error);
               } else {
                   
                   for(NSDictionary *item in result)
                   {
                       
                       F3RCustomComment *customComment = [[F3RCustomComment alloc] init];
                       
                       for (NSString *key in item) {
                           
                           
                           
                           if ([customComment respondsToSelector:NSSelectorFromString(key)]) {
                               
                               [customComment setValue:[item valueForKey:key] forKey:key];
                           }
                           
                           
                       }
                       
                       
                       [collection addObject:customComment];
                       
                       
                   }
                   
                   [self.tableView reloadData];
                   
               }
               /*
                [self.activityIndicator stopAnimating];
                
                if (collection.count == 0) {
                [self.errorView setHidden:NO];
                }
                else
                {
                [self.errorView setHidden:YES];
                }
                
                */
               
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
    static NSString * cellIdentifier = @"commentTableViewCell";
    
    F3RCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[F3RCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    F3RCustomComment  *comment = [collection objectAtIndex:row];
    
    [cell.lblUserName setText:comment.nombre];
    [cell.lblCommentDescription setText:comment.descripcion];
    
    // imagen perfil de usuario
    [cell.imgUser sd_setImageWithURL:[NSURL URLWithString:comment.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    // se establecen los bordes redondos
    [cell.imgUser.layer setCornerRadius: cell.imgUser.frame.size.width / 2];
    [cell.imgUser setClipsToBounds:YES];
    
    return cell;
}


@end
