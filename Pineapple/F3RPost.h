//
//  F3RPost.h
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface F3RPost : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *nombre;
@property (strong, nonatomic) NSString *urlimagen;
@property (strong, nonatomic) NSString *fechadesaparicion;
@property (strong, nonatomic) NSString *idusuario;
@property (strong, nonatomic) NSString *idestado;
@property (strong, nonatomic) NSString *idcategoria;
@property (strong, nonatomic) NSString *idprovincia;
@property (strong, nonatomic) NSNumber *cantidad_reportes;
@property (strong, nonatomic) NSString *latitud;
@property (strong, nonatomic) NSString *longitud;
@property ( nonatomic) bool *solved;

@end
