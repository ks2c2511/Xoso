//
//  UIImage+DrawColor.m
//  HiVn
//
//  Created by Khoa Le on 5/13/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "UIImage+DrawColor.h"

@implementation UIImage (DrawColor)


+(UIImage*)DrawImageWithSize:(CGSize )size Color:(NSArray *)color{
    UIGraphicsBeginImageContext(size);
    for(int i=0;i<color.count;i++){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [color[i] CGColor]);
        CGContextSetFillColorWithColor(context, [color[i] CGColor]);
        CGContextFillRect(context, CGRectMake((size.width/color.count)*i, 0.0, size.width/color.count, size.height));
        //===========================================================
        //  Draw Image Text
        //===========================================================
        
    }
    UIImage * resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
@end
