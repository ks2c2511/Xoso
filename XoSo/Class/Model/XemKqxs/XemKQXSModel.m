//
//  XemKQXSModel.m
//  XoSo
//
//  Created by Khoa Le on 7/8/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "XemKQXSModel.h"


@implementation XemKQXSModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"RESULT_ID": @"RESULT_ID",
             @"COMPANY_ID":@"COMPANY_ID",
             @"PRIZE_ID":@"PRIZE_ID",
             @"RESULT_DATE":@"RESULT_DATE",
             @"RESULT_NUMBER":@"RESULT_NUMBER",
             @"RESULT_DESC":@"RESULT_DESC"};
}
@end
