//
//  ThongkeDauduoiHeader.m
//  XoSo
//
//  Created by Khoa Le on 8/7/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeDauduoiHeader.h"

@implementation ThongkeDauduoiHeader

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ThongkeDauduoiHeader class]) owner:nil options:nil][0];

    if (self) {
    }

    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
