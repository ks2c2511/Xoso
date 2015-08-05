//
//  LotoTypeModel.m
//  XoSo
//
//  Created by Khoa Le on 7/27/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LotoTypeModel.h"

@implementation LotoTypeModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"LOTTO_TYPE_ID": @"LOTTO_TYPE_ID",
             @"TYPE_NAME":@"TYPE_NAME",
             @"COMPANY_ID":@"COMPANY_ID",
             @"COUPBLE":@"COUPBLE",
             @"MULTIPLE":@"MULTIPLE",
             @"UNIT":@"UNIT",
             @"DAY_ID":@"DAY_ID"};
}
@end
