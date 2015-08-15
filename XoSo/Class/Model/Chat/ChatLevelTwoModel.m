//
//  ChatLevelTwoModel.m
//  XoSo
//
//  Created by Khoa Le on 8/15/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChatLevelTwoModel.h"

@implementation ChatLevelTwoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"comment_id": @"comment_id",
             @"user_name": @"user_name",
             @"subject_id": @"subject_id",
             @"comment_content": @"comment_content"};
}
@end
