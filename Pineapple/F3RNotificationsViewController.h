//
//  F3RNotificationsViewController.h
//  Pineapple
//
//  Created by user on 1/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F3RNotificationsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *errorView;

@end
