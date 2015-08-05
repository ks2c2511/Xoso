//
//  NSString+FromArray.m
//  XoSo
//
//  Created by Khoa Le on 7/29/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "NSString+FromArray.h"

@implementation NSString (FromArray)
+(NSString *)stringFromArray:(NSArray *)arr {
    
    NSString *str =@"";;
    for (int i = 0; i < arr.count; i++) {
        if (i==0) {
            str = [NSString stringWithFormat:@"%@",arr[i]];
        }
        else {
            str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",arr[i]]];
        }
    }
    return str;
}
@end
