//
//  ThongkeChuaVeCell.m
//  XoSo
//
//  Created by Khoa Le on 8/7/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeChuaVeCell.h"

@implementation ThongkeChuaVeCell

-(id)initWithFrame:(CGRect)frame {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ThongkeChuaVeCell class]) owner:nil options:nil][0];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib {
}

@end
