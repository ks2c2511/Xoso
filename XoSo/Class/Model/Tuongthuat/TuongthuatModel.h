//
//  TuongthuatModel.h
//  XoSo
//
//  Created by Khoa Le on 8/6/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
@interface TuongthuatModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *idTuongthuat;
@property (strong,nonatomic) NSString *ma_mien;
@property (strong,nonatomic) NSString *ma_tinh;
@property (strong,nonatomic) NSString *ma_giai;
@property (strong,nonatomic) NSString *ket_qua;

@end
