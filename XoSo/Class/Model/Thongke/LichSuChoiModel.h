//
//  LichSuChoiModel.h
//  XoSo
//
//  Created by Khoa Le on 8/9/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface LichSuChoiModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSString *capso;
@property (strong,nonatomic) NSString *tong;
@property (strong,nonatomic) NSString *trung;
@end
