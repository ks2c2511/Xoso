//
//  UIFont+Traits.m
//  HalloVn
//
//  Created by Trung Nghiem Toan on 6/20/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "UIFont+Traits.h"

@implementation UIFont (Traits)

-(CTFontSymbolicTraits)traits
{
    CTFontRef fontRef = (__bridge CTFontRef)self;
    CTFontSymbolicTraits symbolicTraits = CTFontGetSymbolicTraits(fontRef);
    return symbolicTraits;
}

-(BOOL)isBold
{
    CTFontSymbolicTraits symbolicTraits = [self traits];
    return (symbolicTraits & kCTFontBoldTrait);
}

-(BOOL)isItalic
{
    CTFontSymbolicTraits symbolicTraits = [self traits];
    return (symbolicTraits & kCTFontItalicTrait);
}

@end
