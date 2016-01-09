//
//  F3RPostDetailViewController.m
//  Pineapple
//
//  Created by user on 1/9/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RPostDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface F3RPostDetailViewController ()
{
    NSDateFormatter *dateFormat;
}
@end

@implementation F3RPostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];

    
    // se cargan los datos
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData
{
    [_lblPostTitle setText:_post.nombre];
    
    [_imgPost sd_setImageWithURL:[NSURL URLWithString:_post.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    [_lblPostDate setText:[NSString stringWithFormat:@"Fecha: %@",[dateFormat stringFromDate:_post.fechadesaparicion]]];
    
    [_lblPostDescription setText:_post.descripcion];
    
    // se verifica cual imagen se debe desplegar, se utiliza un operador ternario
    NSString * typeNameImage = [_post.idestado isEqualToString:@"0"] ? @"found.png" : @"lost.png";
    [_imgType setImage:[UIImage imageNamed:typeNameImage]];
    
    typeNameImage = [_post.idestado isEqualToString:@"0"] ? @"Encontrad@" : @"Perdid@";
    [_lblCategory setText:typeNameImage];
    
    typeNameImage = [_post.solved isEqualToNumber:[NSNumber numberWithInt:0]] ? @"unsolved.png" : @"solved.png";
    [_imgSolvedStatus setImage:[UIImage imageNamed:typeNameImage]];
    
    typeNameImage = [_post.solved isEqualToNumber:[NSNumber numberWithInt:0]] ? @"Pendiente" : @"Resuelto";
    [_lblSolvedStatus setText:typeNameImage];
    
    
    typeNameImage =  [_post.estado_follow isEqualToNumber:[NSNumber numberWithInt:0]] ? @"follow.png" : @"unfollow.png";
    [_imgFollowStatus setImage:[UIImage imageNamed:typeNameImage]];
    
    typeNameImage =  [_post.estado_follow isEqualToNumber:[NSNumber numberWithInt:0]] ? @"Seguir" : @"Dejar de seguir";
    [_lblFollowStatus setText:typeNameImage];
    
    [_lblQuantityComments setText:[NSString stringWithFormat:@"%@",_post.cantidad_comentarios]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
