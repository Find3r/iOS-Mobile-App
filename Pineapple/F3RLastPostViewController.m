//
//  F3RLastPostViewController.m
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RLastPostViewController.h"
#import "AppDelegate.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "F3RLastPostTableViewCell.h"
#import "F3RCustomPost.h"
#import "F3RFacebookUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface F3RLastPostViewController ()
{
    NSMutableArray *collection;
    NSDateFormatter *dateFormat;
}
@end

@implementation F3RLastPostViewController

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
    
    NSDictionary *parameters = @{ @"id": F3RFacebookUser.user.id };
    
    [client invokeAPI:@"last_newsaux"
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
                       
                       F3RCustomPost *customPost = [[F3RCustomPost alloc] init];
                       
                       for (NSString *key in item) {
                           if ([customPost respondsToSelector:NSSelectorFromString(key)]) {
                               [customPost setValue:[item valueForKey:key] forKey:key];
                           }
                       }
                       
                       
                       [collection addObject:customPost];
                       
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
    static NSString * cellIdentifier = @"lastPostTableViewCell";
    
    F3RLastPostTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[F3RLastPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    F3RCustomPost  *post = [collection objectAtIndex:row];
    
    [cell.lblUserName setText:post.nombre_usuario];
    [cell.lblPostName setText:post.nombre];
    [cell.lblDate setText:[NSString stringWithFormat:@"Fecha: %@",[dateFormat stringFromDate:post.fechadesaparicion]]];
    [cell.lblDescription setText:post.descripcion];
    
    [cell.imgPost sd_setImageWithURL:[NSURL URLWithString:post.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];

    [cell.imgUser sd_setImageWithURL:[NSURL URLWithString:post.urlimagen_perfil_usuario]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    [cell.imgUser.layer setCornerRadius: cell.imgUser.frame.size.width / 2];
    
    [cell.imgUser setClipsToBounds:YES];
    
    
    NSLog(@"%@",post.urlimagen_perfil_usuario);

    /*
     
     
    
    [cell.lblDate setText:[NSString stringWithFormat:@"Fecha: %@",[dateFormat stringFromDate:event.fecha_aux]]];
    [cell.lblHour setText:[NSString stringWithFormat:@"Hora: %@",event.hora]];
    [cell.lblAmount setText:[NSString stringWithFormat:@"Costo: %@",event.costo]];
    
       */
    
    
    //[cell.layer setCornerRadius:35.0f];
    
    [cell updateConstraintsIfNeeded];
    
    return cell;
}
/*

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"eventDetail"])
    {
        EventDetailViewController * view = [segue destinationViewController];
        
        NSIndexPath * myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath section];
        
        Event  *event = [collection objectAtIndex:row];
        
        view.event = event;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // mostramos el segue
    [self performSegueWithIdentifier:@"eventDetail" sender:self];
    
}
*/

@end

