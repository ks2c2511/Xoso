//
//  ChonCuocCell.m
//  XoSo
//
//  Created by Khoa Le on 7/21/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChonCuocCell.h"

@implementation ChonCuocCell

-(id)initWithFrame:(CGRect)frame {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ChonCuocCell class]) owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    
    self.labelNumber.layer.cornerRadius = 5.0;
    self.labelNumber.layer.masksToBounds = YES;
}

@end
