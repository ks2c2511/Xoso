//
//  LichSuChoiModel.m
//  XoSo
//
//  Created by Khoa Le on 8/9/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LichSuChoiModel.h"

@implementation LichSuChoiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"username": @"username",
             @"city": @"city",
             @"capso": @"capso",
             @"tong": @"tong",
             @"trung": @"trung"};
}
@end
