//
//  HistoryModel.m
//  XoSo
//
//  Created by Khoa Le on 7/29/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"LOTTO_ID": @"LOTTO_ID",
             @"USER_ID": @"USER_ID",
             @"DATE": @"DATE",
             @"LOTTO_TYPE_ID": @"LOTTO_TYPE_ID",
             @"LOTTO_NUMBER": @"LOTTO_NUMBER",
             @"POINT_NUMBER": @"POINT_NUMBER",
             @"ITERATIONS": @"ITERATIONS",
             @"POINT_REVEICED": @"POINT_REVEICED",
             @"STATUS": @"STATUS",
             @"TYPE_NAME": @"TYPE_NAME",
             @"COMPANY_NAME": @"COMPANY_NAME"};
}
@end
