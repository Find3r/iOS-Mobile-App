//
//  F3RLastPostTableViewCell.h
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F3RLastPostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIImageView *imgPost;
@property (weak, nonatomic) IBOutlet UILabel *lblPostName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusFollow;
@property (weak, nonatomic) IBOutlet UIImageView *imgCategory;
@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgStatusFollow;

@end
