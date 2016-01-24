//
//  F3RMyProfileViewController.h
//  Pineapple
//
//  Created by user on 1/14/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F3RNotificationTableViewCell.h"

@interface F3RMyProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *vista;
@property (weak, nonatomic) F3RNotificationTableViewCell *cellHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblTest;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic, strong) UITableView *tableView;

@end
