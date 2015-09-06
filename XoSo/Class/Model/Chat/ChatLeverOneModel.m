//
//  ChatLeverOneModel.m
//  XoSo
//
//  Created by Khoa Le on 8/15/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChatLeverOneModel.h"

@implementation ChatLeverOneModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"subject_id": @"subject_id",
             @"user_name": @"user_name",
             @"subject_content": @"subject_content",
             @"like_count": @"like_count",
             @"comment_count": @"comment_count",
             @"create_date": @"create_date",
             @"admin": @"admin",
             };
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

+ (NSValueTransformer *)create_dateJSONTransformer {
    
    return [MTLValueTransformer transformerWithBlock:^id(NSString *dateString) {
        return [self.dateFormatter dateFromString:dateString];
    }];
    
}
@end
