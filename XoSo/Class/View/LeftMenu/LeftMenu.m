//
//  LeftMenu.m
//  XoSo
//
//  Created by Khoa Le on 7/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LeftMenu.h"
#import "LeftMenuCell.h"
#import "ConstantDefine.h"


static NSString *const identifi_LeftMenuCell = @"identifi_LeftMenuCell";
@interface LeftMenu () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *arrData;
@end

@implementation LeftMenu

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self settingTableMenu];
    }
    return self;
}
-(void)awakeFromNib {
    [self settingTableMenu];
}

-(void)settingTableMenu {
    _arrData = [[NSArray alloc]
                initWithContentsOfFile:[[NSBundle mainBundle]
                                        pathForResource:@"LeftMenuData"
                                        ofType:@"plist"]];
    
    [self registerClass:[LeftMenuCell class] forCellReuseIdentifier:identifi_LeftMenuCell];
    self.dataSource = self;
    self.delegate = self;
    self.tableFooterView = [UIView new];
    
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifi_LeftMenuCell forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(LeftMenuCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell.labelTitle.text = self.arrData[indexPath.row][@"title"];
    [cell.imageLogo setImage:[UIImage imageNamed:self.arrData[indexPath.row][@"icon"]]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
#if DEBUG
    NSLog(@"---log---> %@",self.arrData[indexPath.row][@"key"]);
#endif
    
    NSString *key = self.arrData[indexPath.row][@"key"];
    if ([key isEqualToString:@"menu_tai_khoan"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowManageUser object:nil];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
