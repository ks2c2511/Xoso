//
//  ThongkeDetailCell.h
//  XoSo
//
//  Created by Khoa Le on 8/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThongkeDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewContainNumber;
@property (weak, nonatomic) IBOutlet UIView *viewContainpercent;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UIView *viewShowPercent;
@property (weak, nonatomic) IBOutlet UILabel *labelPercent;
@end
