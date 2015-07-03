//
//  UIFont+Traits.h
//  HalloVn
//
//  Created by Trung Nghiem Toan on 6/20/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface UIFont (Traits)

-(CTFontSymbolicTraits)traits;
-(BOOL)isBold;
-(BOOL)isItalic;

@end
