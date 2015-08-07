//
//  ThongkeTable.m
//  XoSo
//
//  Created by Khoa Le on 8/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeTable.h"

@interface ThongkeTable () <UITableViewDataSource,UITableViewDelegate>

@end
@implementation ThongkeTable


-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self customTable];
    }
    return self;
}
-(void)awakeFromNib {
    [self customTable];
}

-(void)customTable {
    [self registerClass:[ThongkeDetailCell class] forCellReuseIdentifier:NSStringFromClass([ThongkeDetailCell class])];
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThongkeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeDetailCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(ThongkeDetailCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.TableCellConfigBlock) {
        self.TableCellConfigBlock(cell,self.arrData[indexPath.row]);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}


-(void)setArrData:(NSArray *)arrData {
    _arrData = arrData;
    [self reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
