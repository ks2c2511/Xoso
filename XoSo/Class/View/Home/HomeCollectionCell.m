//
//  HomeCollectionCell.m
//  XoSo
//
//  Created by Khoa Le on 7/5/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HomeCollectionCell.h"

@implementation HomeCollectionCell

-(id)initWithFrame:(CGRect)frame {
    self = [[NSBundle mainBundle] loadNibNamed:@"HomeCollectionCell" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    
    self.labelTitle.layer.masksToBounds = YES;
    self.labelTitle.layer.cornerRadius = 10.0;
}

@end
