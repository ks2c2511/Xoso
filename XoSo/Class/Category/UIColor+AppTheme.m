//
//  UIColor+AppTheme.m
//  HalloVn
//
//  Created by Trung Nghiem Toan on 6/13/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "UIColor+AppTheme.h"

@implementation UIColor (AppTheme)
+(UIColor *)appPurpleColor{
    return [UIColor colorWithRed:68.0 / 255.0 green:55.0 / 255.0 blue:86.0 / 255.0 alpha:1];
}
+(UIColor *)appRedBackgroundColor{
    return [UIColor colorWithRed:250.0 / 255.0 green:40.0 / 255.0 blue:12.0 / 255.0 alpha:1];
}
+(UIColor *)appGrayTextColor{
    return [UIColor colorWithRed:142.0 / 255.0 green:108.0 / 255.0 blue:72.0 / 255.0 alpha:1];
}
+(UIColor *)appNavigationBarColor{
    return [UIColor colorWithRed:52.0 / 255.0 green:164.0 / 255.0 blue:37.0 / 255.0 alpha:1];
}

+(UIColor *)appVioletNavigationBarColor {
    return [UIColor colorWithRed:154.0 / 255.0 green:39.0 / 255.0 blue:197.0 / 255.0 alpha:1];
}

+(UIColor *)appOrange{
    return [UIColor colorWithRed:228.0 / 255.0 green:171.0 / 255.0 blue:46.0 / 255.0 alpha:1];
}
@end
