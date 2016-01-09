//
//  F3RCustomPost.m
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RCustomPost.h"

@implementation F3RCustomPost

- (id) init
{

    if (self = [super init])
    {
        _cantidad_comentarios = 0;
        _nombre_usuario = @"";
        _urlimagen_perfil_usuario = @"";
        _nombre_provincia = @"";
        _estado_follow = 0;

    }
    return self;
}

@end
