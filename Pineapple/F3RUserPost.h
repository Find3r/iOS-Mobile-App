//
//  F3RUserPost.h
//  Pineapple
//
//  Created by user on 1/25/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface F3RUserPost : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *idusuario;
@property (strong, nonatomic) NSString *idnoticia;
@property (strong, nonatomic) NSNumber *estado_seguimiento;

- (id) initWithIdUser:(NSString *)pIdUser
               IdPost:(NSString *) pIdPost
         FollowStatus:(NSNumber *)pFollowStatus;

@end
