//
//  KetquaXosoMainCell.h
//  XoSo
//
//  Created by Khoa Le on 7/8/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KetquaXosoMainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelResult;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contraint_W_lableNumber;

@end
