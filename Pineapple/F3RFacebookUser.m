//
//  F3RFacebookUser.m
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RFacebookUser.h"

static F3RFacebookUser *user = nil;

@implementation F3RFacebookUser

+ (F3RFacebookUser *) user
{
    if (user == nil) user = [[F3RFacebookUser alloc] init];
    return user;
}

@end
