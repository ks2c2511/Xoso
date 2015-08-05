//
//  ChonTypeCollectionCellCollectionViewCell.m
//  XoSo
//
//  Created by Khoa Le on 7/27/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChonTypeCollectionCellCollectionViewCell.h"

@implementation ChonTypeCollectionCellCollectionViewCell

-(id)initWithFrame:(CGRect)frame {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ChonTypeCollectionCellCollectionViewCell class]) owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    self.labelType.layer.cornerRadius = 5.0;
    self.labelType.layer.masksToBounds = YES;
}

@end
