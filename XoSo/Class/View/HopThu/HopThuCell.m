//
//  HopThuCell.m
//  XoSo
//
//  Created by Khoa Le on 8/19/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HopThuCell.h"

@implementation HopThuCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HopThuCell class]) owner:nil options:nil][0];
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
