//
//  TableListItem.m
//  XoSo
//
//  Created by Khoa Le on 7/10/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "TableListItem.h"



static NSString *const identifi_TableListCell = @"identifi_TableListCell";

@interface TableListItem ()
@property (assign,nonatomic) BOOL isShow;
@end
@implementation TableListItem

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
    [self registerClass:[TableListCell class] forCellReuseIdentifier:identifi_TableListCell];
    self.delegate = self;
    self.dataSource = self;
    self.alpha = 0;
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:.8];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifi_TableListCell forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(TableListCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.TableViewCellConfigBlock) {
        self.TableViewCellConfigBlock (cell,self.arrData[indexPath.row]);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.SelectItem) {
        self.SelectItem(indexPath,self.arrData[indexPath.row]);
    }
    [self showOrHiden];
}

-(void)showOrHiden {
    
    self.isShow =!self.isShow;
    [UIView animateWithDuration:.35 animations:^{
        if (self.isShow) {
             self.alpha = 1;
        }
        else {
            self.alpha = 0;
        }
       
    }];
    
}

-(void)setArrData:(NSArray *)arrData {
    _arrData =arrData;
    [self reloadData];
}



@end
