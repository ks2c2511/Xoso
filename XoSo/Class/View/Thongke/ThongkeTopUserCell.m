//
//  ThongkeTopUserCell.m
//  XoSo
//
//  Created by Khoa Le on 8/10/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeTopUserCell.h"

@implementation ThongkeTopUserCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ThongkeTopUserCell class]) owner:nil options:nil][0];
    
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
