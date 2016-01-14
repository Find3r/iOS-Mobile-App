//
//  F3RCommentsViewController.h
//  Pineapple
//
//  Created by user on 1/10/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F3RCommentsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

@property (weak, nonatomic) NSString *idPost;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *errorView;

@end
