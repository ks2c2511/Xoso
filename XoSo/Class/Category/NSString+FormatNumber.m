//
//  NSString+FormatNumber.m
//  HalloVn
//
//  Created by Khoa Le on 6/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "NSString+FormatNumber.h"

@implementation NSString (FormatNumber)
- (NSString *)stringDecima
{
    
    NSString *v = [NSString stringWithFormat:@"%f",[self floatValue]];
    
    if ([self floatValue] == -1 || [v isEqualToString:@"nan"]) {
        return @"";
    }
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    fmt.numberStyle = NSNumberFormatterDecimalStyle;
    fmt.usesGroupingSeparator = YES;
    [fmt setGroupingSeparator:@","];
    [fmt setDecimalSeparator:@"."];
    [fmt setMaximumFractionDigits:2];
    [fmt setMinimumFractionDigits:0];
    return [fmt stringFromNumber:@([self floatValue])];
}
@end
