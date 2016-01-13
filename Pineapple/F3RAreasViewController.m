//
//  F3RAreasViewController.m
//  Pineapple
//
//  Created by user on 1/10/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RAreasViewController.h"
#import "AppDelegate.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "F3RAreaCollectionViewCell.h"
#import "F3RCategory.h"
#import "F3RFacebookUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation F3RAreasViewController
{
    NSMutableArray *collection;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
    [self.collectionView setDataSource:self];
    
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
    
    
    [client invokeAPI:@"categorias"
                 body:nil
           HTTPMethod:@"GET"
           parameters:nil
              headers:nil
           completion:  ^(NSDictionary *result,
                          NSHTTPURLResponse *response,
                          NSError *error){
               if(error) { // error is nil if no error occured
                   NSLog(@"ERROR %@", error);
               } else {
                   
                   for(NSDictionary *item in result)
                   {
                       
                       F3RCategory *category = [[F3RCategory alloc] init];
                       
                       for (NSString *key in item) {
                           
                           
                           
                           if ([category respondsToSelector:NSSelectorFromString(key)]) {
                               
                               [category setValue:[item valueForKey:key] forKey:key];
                           }
                           
                           
                       }
                       
                       
                       [collection addObject:category];
                       
                       
                   }
                   
                   [self.collectionView reloadData];
                   
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



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collection.count;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"categoryCollectionViewCell";
    
    F3RAreaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    long row = [indexPath row];
    
    
    F3RCategory  *category = [collection objectAtIndex:row];
    
    [cell.lblName setText:category.nombre];
    
    // imagen perfil de usuario
    [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:category.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    return cell;

}

#pragma mark – UICollectionViewDelegateFlowLayout



@end
