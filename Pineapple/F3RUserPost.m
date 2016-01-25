//
//  F3RUserPost.m
//  Pineapple
//
//  Created by user on 1/25/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RUserPost.h"

@implementation F3RUserPost

- (id) initWithIdUser:(NSString *)pIdUser
               IdPost:(NSString *) pIdPost
         FollowStatus:(NSNumber *)pFollowStatus
{
    
    if (self = [super init])
    {
        _idnoticia = pIdPost;
        _idusuario = pIdUser;
        _estado_seguimiento = pFollowStatus;
        
    }
    
    return self;
}

@end
