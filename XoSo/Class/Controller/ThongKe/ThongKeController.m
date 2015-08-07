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
