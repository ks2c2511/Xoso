//
//  UIColor+AppTheme.m
//  HalloVn
//
//  Created by Trung Nghiem Toan on 6/13/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "UIColor+AppTheme.h"

@implementation UIColor (AppTheme)
+(UIColor *)appGrayTextColor{
    return [UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1];
}
+(UIColor *)appGraySubTextColor{
    return [UIColor colorWithRed:81.0 / 255.0 green:82.0 / 255.0 blue:83.0 / 255.0 alpha:1];
}
+(UIColor *)appGrayImageBorder{
    return [UIColor colorWithRed:195.0 / 255.0 green:196.0 / 255.0 blue:197.0 / 255.0 alpha:1];
}
+(UIColor *)appNavigationBarColor{
    return [UIColor colorWithRed:66.0 / 255.0 green:68.0 / 255.0 blue:153.0 / 255.0 alpha:1];
}
@end
