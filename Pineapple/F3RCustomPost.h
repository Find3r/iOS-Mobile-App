//
//  F3RCustomPost.h
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RPost.h"

@interface F3RCustomPost : F3RPost

@property (strong, nonatomic) NSString *nombre_usuario;
@property (strong, nonatomic) NSString *urlimagen_perfil_usuario;
@property (strong, nonatomic) NSString *nombre_provincia;
@property (strong, nonatomic) NSNumber *cantidad_comentarios;
@property (nonatomic) bool *estado_follow;

@end
