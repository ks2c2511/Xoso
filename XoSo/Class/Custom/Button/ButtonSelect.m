//
//  ButtonSelect.m
//  XoSo
//
//  Created by Khoa Le on 8/9/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ButtonSelect.h"


static NSInteger const heightUnselect = 2;
static NSInteger const heightSelect = 7;


@implementation ButtonSelect



- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:171.0/255.0 green:16.0/255.0 blue:6.0/255.0 alpha:1.0].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:171.0/255.0 green:16.0/255.0 blue:6.0/255.0 alpha:1.0].CGColor);
    
    if (self.isSelect) {
        CGContextSetLineWidth(context, heightSelect);
        CGContextMoveToPoint(context, 0.0, rect.size.height -heightSelect);
        CGContextAddLineToPoint(context, 0.0, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height -heightSelect);

    }
    else {
        CGContextSetLineWidth(context, heightUnselect);
        CGContextMoveToPoint(context, 0.0, rect.size.height -heightUnselect);
        CGContextAddLineToPoint(context, 0.0, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height -heightUnselect);
    }
    
        CGContextDrawPath(context, kCGPathFill);
        CGContextClosePath(context);
}

-(void)setIsSelect:(BOOL)isSelect {
    [self clearsContextBeforeDrawing];
    
    _isSelect = isSelect;
    
    [self setNeedsDisplay];
}


@end
