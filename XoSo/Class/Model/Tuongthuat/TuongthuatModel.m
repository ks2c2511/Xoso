//
//  TuongthuatModel.m
//  XoSo
//
//  Created by Khoa Le on 8/6/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "TuongthuatModel.h"

@implementation TuongthuatModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"idTuongthuat": @"id",
             @"ma_mien":@"ma_mien",
             @"ma_tinh":@"ma_tinh",
             @"ma_giai":@"ma_giai",
             @"ket_qua":@"ket_qua"};
    
}
@end
