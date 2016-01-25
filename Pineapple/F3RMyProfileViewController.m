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
#import "F3RLastPostTableViewCell.h"
#import "F3RCustomPost.h"
#import "F3RPostDetailViewController.h"

static CGFloat const kWindowHeight = 235.0f;
static NSString * const kCellIdentify = @"lastPostTableViewCell";

@implementation F3RMyProfileViewController
{
    NSMutableArray *collection;
    NSMutableArray *collectionMyPosts;
    NSMutableArray *collectionMyFollwingPosts;
    
    
    NSDateFormatter *dateFormat;
    
    UITapGestureRecognizer *showDescriptionPostTap;
    UITapGestureRecognizer *updateFollowStatusPostTap;
    UITapGestureRecognizer *showCommentsPostTap;
   
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    // se establece el listener del segment control
    [headerView.segmentControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
     
    
    
    //[self.tableView setDataSource:self];
    
  
    
    //[self.activityIndicator startAnimating];
    
 
    [self loadMyPosts:YES];
    [self loadMyFollowingPosts];
}

- (void) viewDidAppear :(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"Hello");
    
    // se oculta navigation bar
    //[self.navigationController setNavigationBarHidden:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadMyPosts:(BOOL) reloadTableView
{
    collection = [[NSMutableArray alloc] init];
    collectionMyPosts = [[NSMutableArray alloc] init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    NSDictionary *parameters = @{ @"id": F3RFacebookUser.user.id };
    
    [client invokeAPI:@"my_news"
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
                       
                       if([item objectForKey:@"estado_follow"] == [NSNull null])
                       {
                           customPost.estado_follow = [NSNumber numberWithInt:0];
                       }
                       
                       if([item objectForKey:@"cantidad_comentarios"] == [NSNull null])
                       {
                           customPost.cantidad_comentarios = [NSNumber numberWithInt:0];
                       }
                       
                       
                       [collectionMyPosts addObject:customPost];
                       
                       
                   }
                   
                   if (reloadTableView)
                   {
                       collection = collectionMyPosts;
                       [self.tableView reloadData];
                   }
                   
                   
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

- (void) updatePostFollowStatus:(NSDictionary *) userPost
{
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    MSTable *table = [client tableWithName:@"noticia_usuario"];
    
    [table insert:userPost completion:^(NSDictionary *result, NSError *error) {
        // The result contains the new item that was inserted,
        // depending on your server scripts it may have additional or modified
        // data compared to what was passed to the server.
        if(error) {
            NSLog(@"ERROR %@", error);
        } else {
            NSLog(@"Todo Item: %@", [result objectForKey:@"id"]);
        }
    }];
}


- (void) loadMyFollowingPosts
{
    collection = [[NSMutableArray alloc] init];
    collectionMyFollwingPosts = [[NSMutableArray alloc] init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    NSDictionary *parameters = @{ @"iduser": F3RFacebookUser.user.id };
    
    [client invokeAPI:@"following_news"
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
                       
                       if([item objectForKey:@"estado_follow"] == [NSNull null])
                       {
                           customPost.estado_follow = [NSNumber numberWithInt:0];
                       }
                       
                       if([item objectForKey:@"cantidad_comentarios"] == [NSNull null])
                       {
                           customPost.cantidad_comentarios = [NSNumber numberWithInt:0];
                       }
                       
                       [collectionMyFollwingPosts addObject:customPost];
                    
                   }
                   
                   
                   
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

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    // se verifica cual es el item seleccionado
    switch (segment.selectedSegmentIndex)
    {
        // mis noticias
        case 0:
            collection = collectionMyPosts;
            break;
            
        case 1:
            collection = collectionMyFollwingPosts;
            break;
        
        default:
            break;
    }
    
    
    [self.tableView reloadData];

}

#pragma mark - tableView Delegate and dataSource

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
    
    [cell.imgPost setTag:row];
    [cell.imgStatusFollow setTag:row];
    [cell.imgComments setTag:row];
    
    // se verifica si ya hay un reconocedor
    if (cell.imgPost.gestureRecognizers.count == 0)
    {
        showDescriptionPostTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDescriptionPostGestureCaptured:)];
        updateFollowStatusPostTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateStatusFollowPostGestureCaptured:)];
        showCommentsPostTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showCommentsGestureCaptured:)];
        
        
        [cell.imgPost addGestureRecognizer:showDescriptionPostTap];
        [cell.imgStatusFollow addGestureRecognizer:updateFollowStatusPostTap];
        [cell.imgComments addGestureRecognizer:showCommentsPostTap];
        
    }
    
    [cell.lblUserName setText:post.nombre_usuario];
    [cell.lblPostName setText:post.nombre];
    [cell.lblDate setText:[NSString stringWithFormat:@"Fecha: %@",[dateFormat stringFromDate:post.fechadesaparicion]]];
    
    [cell.imgPost sd_setImageWithURL:[NSURL URLWithString:post.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    // imagen perfil de usuario
    [cell.imgUser sd_setImageWithURL:[NSURL URLWithString:post.urlimagen_perfil_usuario]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    // se establecen los bordes redondos
    [cell.imgUser.layer setCornerRadius: cell.imgUser.frame.size.width / 2];
    [cell.imgUser setClipsToBounds:YES];
    
    // se verifica cual imagen se debe desplegar, se utiliza un operador ternario
    NSString * typeNameImage = [post.idestado isEqualToString:@"0"] ? @"found.png" : @"lost.png";
    [cell.imgType setImage:[UIImage imageNamed:typeNameImage]];
    
    typeNameImage = [post.idestado isEqualToString:@"0"] ? @"Encontrad@" : @"Perdid@";
    [cell.lblCategory setText:typeNameImage];
    
    typeNameImage = [post.solved isEqualToNumber:[NSNumber numberWithInt:0]] ? @"unsolved.png" : @"solved.png";
    [cell.imgStatus setImage:[UIImage imageNamed:typeNameImage]];
    
    typeNameImage = [post.solved isEqualToNumber:[NSNumber numberWithInt:0]] ? @"Pendiente" : @"Resuelto";
    [cell.lblStatus setText:typeNameImage];
    
    
    typeNameImage =  [post.estado_follow isEqualToNumber:[NSNumber numberWithInt:0]] ? @"follow.png" : @"unfollow.png";
    [cell.imgStatusFollow setImage:[UIImage imageNamed:typeNameImage]];
    
    typeNameImage =  [post.estado_follow isEqualToNumber:[NSNumber numberWithInt:0]] ? @"Seguir" : @"Dejar de seguir";
    [cell.lblStatusFollow setText:typeNameImage];
    
    [cell.lblQuantityComments setText:[NSString stringWithFormat:@"%@",post.cantidad_comentarios]];
    
    return cell;
}

- (void)showDescriptionPostGestureCaptured:(UITapGestureRecognizer*)gesture{
    
    // se instancia el view controller
    F3RPostDetailViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"post_info"];
    
    
    // obtenemos el objeto de la posición seleccionada
    F3RCustomPost  *post = [collection objectAtIndex:gesture.view.tag];
    
    // pasamos el objeto a la vista de detalle
    view.post = post;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    // se redirigue a la vista de detalle del post
    [self.navigationController pushViewController:view animated:YES];
    
}

- (void)updateStatusFollowPostGestureCaptured:(UITapGestureRecognizer*)gesture{
    
    // se obtiene el item seleccionado
    F3RCustomPost  *post = [collection objectAtIndex:gesture.view.tag];
    
    post.estado_follow = [post.estado_follow isEqualToNumber:[NSNumber numberWithInt:0]] ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
    
    // se recarga el tableview
    [self.tableView reloadData];
    
    
    // se actualiza el registro
    NSDictionary *newItem = @{@"idusuario": F3RFacebookUser.user.id, @"idnoticia": post.id, @"estado_seguimiento" : [post.estado_follow isEqualToNumber:[NSNumber numberWithInt:0]] ? @NO : @YES};
    
    [self updatePostFollowStatus:newItem];
    
}

- (void)showCommentsGestureCaptured:(UITapGestureRecognizer*)gesture{
    NSLog(@"Click comments");
    // se instancia el view controller
    F3RCommentsViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"comments"];
    
    
    // obtenemos el objeto de la posición seleccionada
    F3RCustomPost  *post = [collection objectAtIndex:gesture.view.tag];
    
    // pasamos el objeto a la vista de detalle
    view.idPost = post.id;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    // se redirigue a la vista de detalle del post
    [self.navigationController pushViewController:view animated:YES];
}

@end
