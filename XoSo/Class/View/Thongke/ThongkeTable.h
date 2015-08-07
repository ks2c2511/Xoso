//
//  ThongkeTable.h
//  XoSo
//
//  Created by Khoa Le on 8/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThongkeDetailCell.h"

static NSInteger const maxWidthpercentView = 190;
@interface ThongkeTable : UITableView
@property (strong, nonatomic) NSArray *arrData;

@property (copy) void (^TableCellConfigBlock)(ThongkeDetailCell *cell, id item);
@property (copy) void (^TableSelectCell)(id item);
@end
