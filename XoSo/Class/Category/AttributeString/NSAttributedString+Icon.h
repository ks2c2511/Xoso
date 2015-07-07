//
//  NSAttributedString+Icon.h
//  HiVn
//
//  Created by Khoa Le on 7/1/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSAttributedString (Icon)
+(NSAttributedString *)addIconWithString:(NSString *)str icon:(UIImage *)icon iconBounds:(CGRect)iconBounds attrDict:(NSDictionary *)attrDict;

+ (NSAttributedString *)atttributeWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color;
@end
