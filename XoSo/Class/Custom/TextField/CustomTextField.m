//
//  CustomTextField.m
//  XoSo
//
//  Created by Khoa Le on 7/28/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib {
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:19.0/255.0 green:89.0/255.0 blue:102.0/255.0 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, 3.0);
    CGContextMoveToPoint(context, 0.0, rect.size.height -5);
    CGContextAddLineToPoint(context, 0.0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height -5);
    CGContextDrawPath(context, kCGPathStroke);

}


@end
