//
//  F3RNotification.h
//  Pineapple
//
//  Created by user on 1/1/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface F3RNotification : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *idnoticia;
@property (strong, nonatomic) NSDate *__createdAt;
@property (strong, nonatomic) NSString *descripcion;
@property (strong, nonatomic) NSString *fecha;
@property (strong, nonatomic) NSString *hora;

@end
