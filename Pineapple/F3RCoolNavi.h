//
//  F3RCoolNavi.h
//  Pineapple
//
//  Created by user on 1/15/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F3RCoolNavi : UIView

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) UISegmentedControl *segmentControl;

// image action
@property (nonatomic, copy) void(^imgActionBlock)();

- (id)initWithFrame:(CGRect)frame backGroudImage:(NSString *)backImageName headerImageURL:(NSString *)headerImageURL title:(NSString *)title subTitle:(NSString *)subTitle;

-(void)updateSubViewsWithScrollOffset:(CGPoint)newOffset;

@end
