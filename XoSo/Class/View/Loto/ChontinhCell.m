//
//  ChontinhCell.m
//  XoSo
//
//  Created by Khoa Le on 7/22/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChontinhCell.h"

@implementation ChontinhCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ChontinhCell class]) owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
    self.buttonChonTinh.layer.cornerRadius = 6.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
