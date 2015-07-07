//
//  NSAttributedString+Icon.m
//  HiVn
//
//  Created by Khoa Le on 7/1/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "NSAttributedString+Icon.h"

@implementation NSAttributedString (Icon)


+(NSAttributedString *)addIconWithString:(NSString *)str icon:(UIImage *)icon iconBounds:(CGRect)iconBounds attrDict:(NSDictionary *)attrDict{
    
    NSMutableAttributedString *tmp =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",str] attributes:attrDict];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = icon;
    
    CGRect rectTemp = iconBounds;
    if (iconBounds.size.width == 0 && iconBounds.size.height == 0) {
        rectTemp = CGRectMake(iconBounds.origin.x, iconBounds.origin.y, icon.size.width, icon.size.height);
    }
    textAttachment.bounds = rectTemp;
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [tmp replaceCharactersInRange:NSMakeRange(0, 1) withAttributedString:attrStringWithImage];
    
    return tmp;
}

+(NSAttributedString *)atttributeWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color {
    text = (text == nil)?@"":text;
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:text attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,color,NSForegroundColorAttributeName, nil]];
    return att;
}

@end
