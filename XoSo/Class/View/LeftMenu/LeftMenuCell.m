//
//  LeftMenuCell.m
//  XoSo
//
//  Created by Khoa Le on 7/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LeftMenuCell.h"

@implementation LeftMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [[NSBundle mainBundle] loadNibNamed:@"LeftMenuCell" owner:nil options:nil][0];
    if (self) {
        
    }
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
