//
//  F3RLastPostTableViewCell.m
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RLastPostTableViewCell.h"

@implementation F3RLastPostTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 5;
    frame.origin.y += 5;
    frame.size.width -= 2 * 5;
    frame.size.height -= 2 * 5;
    [super setFrame:frame];
}

@end
