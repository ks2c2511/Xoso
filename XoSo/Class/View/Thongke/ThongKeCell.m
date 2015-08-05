//
//  ThongKeCell.m
//  XoSo
//
//  Created by Khoa Le on 8/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongKeCell.h"

@implementation ThongKeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ThongKeCell class]) owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
    self.labelTitle.layer.cornerRadius = 10;
    self.labelTitle.layer.masksToBounds = YES;
    self.labelThongke.layer.cornerRadius = 16;
    self.labelThongke.layer.borderWidth = 2.0;
    self.labelThongke.layer.borderColor =self.labelThongke.textColor.CGColor;
    self.labelThongke.layer.masksToBounds = YES;
    self.viewBOundThongke.layer.cornerRadius = 20;
    self.viewBOundThongke.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
