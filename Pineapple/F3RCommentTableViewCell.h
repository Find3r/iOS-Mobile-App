//
//  F3RCommentTableViewCell.h
//  Pineapple
//
//  Created by user on 1/10/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F3RCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentDescription;


@end
