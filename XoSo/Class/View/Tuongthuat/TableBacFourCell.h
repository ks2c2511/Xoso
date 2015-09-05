//
//  TableBacFourCell.h
//  XoSo
//
//  Created by Khoa Le on 8/2/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableBacFourCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelNUmber1;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber2;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber3;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contraint_W_Label;

@end
