//
//  F3RLastPostViewController.h
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F3RLastPostViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *errorView;

@end
