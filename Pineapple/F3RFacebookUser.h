//
//  F3RFacebookUser.h
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface F3RData2 : NSObject

@property (strong, nonatomic) NSString *url;

@end

@interface F3RData : NSObject

@property (strong, nonatomic) F3RData2 *data;

@end


@interface F3RCoverPhoto : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *source;

@end

@interface F3RFacebookUser : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *last_name;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) F3RData *picture;
@property (strong, nonatomic) F3RCoverPhoto *cover;
+ (F3RFacebookUser *) user;

@end






