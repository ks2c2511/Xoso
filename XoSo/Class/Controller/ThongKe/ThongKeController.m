//
//  ThongKeController.m
//  XoSo
//
//  Created by Khoa Le on 7/26/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongKeController.h"
#import "ThongKeCell.h"
#import "ThongkeSoController.h"
#import "ThongkeDauduoiController.h"
#import "TongHaiSoController.h"
#import "LichsuchoiController.h"
#import "ThongkechukeController.h"
#import "ThongkeUserController.h"


@interface ThongKeController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *arrData;

@end

@implementation ThongKeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Thống kê";
    
    [self.tableView registerClass:[ThongKeCell class] forCellReuseIdentifier:NSStringFromClass([ThongKeCell class])];


    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThongKeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongKeCell class]) forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(ThongKeCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.labelTitle.text = self.arrData[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        ThongkeSoController *thongkeSo = [ThongkeSoController new];
        [self.navigationController pushViewController:thongkeSo animated:YES];
    }
    else if (indexPath.row == 1) {
        ThongkeDauduoiController *dauduoi = [ThongkeDauduoiController new];
        [self.navigationController pushViewController:dauduoi animated:YES];
    }
    else if (indexPath.row == 2) {
        TongHaiSoController *tong = [TongHaiSoController new];
        [self.navigationController pushViewController:tong animated:YES];
    }
    else if (indexPath.row == 3) {
        LichsuchoiController *lichsuchoi = [LichsuchoiController new];
        [self.navigationController pushViewController:lichsuchoi animated:YES];
    }
    else if (indexPath.row == 4) {
        ThongkechukeController *chuki = [ThongkechukeController new];
        [self.navigationController pushViewController:chuki animated:YES];
    }
    else if (indexPath.row == 5) {
        ThongkeUserController *user =[ThongkeUserController new];
        [self.navigationController pushViewController:user animated:YES];
    }
}



-(NSArray *)arrData {
    if (!_arrData) {
        _arrData = @[@"Thống kê từ 00 - 99",
                     @"Thống kê đầu đuôi",
                     @"Cặp loto chơi trong ngày",
                     @"Lịch sử chơi của các user",
                     @"Thống kê theo chu kì",
                     @"Top người chơi loto online"];
    }
    return _arrData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
