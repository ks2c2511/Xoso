//
//  ThongkeTrungcaoModel.h
//  XoSo
//
//  Created by Khoa Le on 8/11/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface ThongkeTrungcaoModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *trung;
@end
