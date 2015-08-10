//
//  ThongKeTopUserFooter.m
//  XoSo
//
//  Created by Khoa Le on 8/10/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongKeTopUserFooter.h"

@implementation ThongKeTopUserFooter

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ThongKeTopUserFooter class]) owner:nil options:nil][0];
    
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
