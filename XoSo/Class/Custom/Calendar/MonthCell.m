//
//  MonthCell.m
//  VTVCalendarIOS
//
//  Created by Khoa Le on 12/24/14.
//  Copyright (c) 2014 Nguyen Dung. All rights reserved.
//

#import "MonthCell.h"

@implementation MonthCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [[NSBundle mainBundle] loadNibNamed:@"MonthCell" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

@end
