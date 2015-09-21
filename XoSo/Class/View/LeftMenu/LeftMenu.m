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
#import <UIAlertView+Blocks.h>
#import "User.h"
#import <NSManagedObject+GzDatabase.h>

static NSString *const identifi_LeftMenuCell = @"identifi_LeftMenuCell";
@interface LeftMenu () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *arrData;
@property (strong, nonatomic) User *user;
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

    
    NSString *key = self.arrData[indexPath.row][@"key"];
    if ([key isEqualToString:@"menu_tai_khoan"]) {
        if ([self checkUser]) {
             [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowManageUser object:nil];
        }
       
    }
    else if ([key isEqualToString:@"menu_dang_nhap"]) {
         [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowLoginOtherUser object:nil];
    }
    else if ([key isEqualToString:@"menu_chia_se"]) {
        if (self.Share) {
            self.Share();
        }
    }
    else if ([key isEqualToString:@"menu_thong_tin"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowInfoUser object:nil];
    }
    else if ([key isEqualToString:@"menu_huong_dan"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowHuongDanUser object:nil];
    }
    else if ([key isEqualToString:@"menu_hop_thu"]) {
        if ([self checkUser]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowHopthu object:nil];
        }
    }
    else if ([key isEqualToString:@"menu_dang_ki"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowDangki object:nil];
    }
    else if ([key isEqualToString:@"menu_cai_dat"]) {
//        [UIAlertView showWithTitle:@"Thông báo" message:@"Tính năng đang cập nhật" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];

         [[NSNotificationCenter defaultCenter] postNotificationName:notificationCaiDat object:nil];
    }
}

-(BOOL)checkUser {
    NSArray * arr = [User fetchAll];
    if (arr.count != 0) {
        _user = [arr firstObject];
    }
    else {
        _user = nil;
    }
    
    if (self.user == nil) {
        [UIAlertView showWithTitle:@"Thông báo" message:@"Bác chưa đăng nhập. Hãy đăng nhập để sử dụng dịch vụ." cancelButtonTitle:@"Huỷ" otherButtonTitles:@[@"Đăng nhập",@"Đăng kí"] tapBlock:^(UIAlertView *alert, NSInteger buttonIxdex) {
            if (buttonIxdex == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowLoginOtherUser object:nil];
            }
            else if (buttonIxdex == 2) {
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowDangki object:nil];
            }
        }];
        return NO;
    }
    else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
