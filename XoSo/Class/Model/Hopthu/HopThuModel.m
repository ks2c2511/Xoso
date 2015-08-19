//
//  HopThuModel.m
//  XoSo
//
//  Created by Khoa Le on 8/19/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HopThuModel.h"


@implementation HopThuModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"idHopthu": @"id",
             @"subject": @"subject",
             @"content": @"content",
             @"trung_lo": @"trung_lo",
             @"date": @"date"};
}
@end
