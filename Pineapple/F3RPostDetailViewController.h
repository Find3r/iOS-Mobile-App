//
//  F3RPostDetailViewController.h
//  Pineapple
//
//  Created by user on 1/9/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F3RCustomPost.h"

@interface F3RPostDetailViewController : UIViewController

@property (weak, nonatomic) F3RCustomPost *post;
@property (weak, nonatomic) IBOutlet UILabel *lblPostTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgPost;
@property (weak, nonatomic) IBOutlet UILabel *lblPostDate;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblSolvedStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblFollowStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantityComments;
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UIImageView *imgSolvedStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgFollowStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgComment;
@property (weak, nonatomic) IBOutlet UITextView *lblPostDescription;

@end
