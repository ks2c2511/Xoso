//
//  TableListItem.h
//  XoSo
//
//  Created by Khoa Le on 7/10/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableListCell.h"
@interface TableListItem : UITableView <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSArray *arrData;

@property (copy) void (^TableViewCellConfigBlock) (id cell, id item);
@property (copy) void (^SelectItem)(NSIndexPath *indexpath, id item);


-(void)showOrHiden;
@end
