//
//  F3RPostCategoryViewController.h
//  Pineapple
//
//  Created by user on 1/25/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F3RPostCategoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) NSString *idCategory;
@property (nonatomic, strong)  IBOutlet UITableView *tableView;

@end
