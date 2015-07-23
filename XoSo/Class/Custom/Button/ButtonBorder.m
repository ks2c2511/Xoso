//
//  ButtonBorder.m
//  XoSo
//
//  Created by Khoa Le on 7/20/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ButtonBorder.h"

@implementation ButtonBorder

-(void)awakeFromNib {
    self.layer.cornerRadius = 6.0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
