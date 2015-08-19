//
//  HuongDanController.m
//  XoSo
//
//  Created by Khoa Le on 8/18/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HuongDanController.h"
#import "HuongdanCell.h"
#import "HuongdanModel.h"

@interface HuongDanController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *arrData;
@end

@implementation HuongDanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.homeButtonItem;
    self.navigationItem.title = @"Hướng dẫn";
    
    [self.tableView registerClass:[HuongdanCell class] forCellReuseIdentifier:NSStringFromClass([HuongdanCell class])];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HuongdanCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuongdanCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(HuongdanCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    HuongdanModel *model = self.arrData[indexPath.row];
    cell.labelTitle.text = model.title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(NSArray *)arrData {
    if (!_arrData) {
        _arrData = @[[self modelxoSo],[self modeltaikhoan],[self modelthaoluan],[self modelthongke],[self modelxemKQXS],[self modeldangnhap],[self modeldangki],[self modelchucnangtaikhoan],[self modelchucnanggiaimong]];
    }
    return _arrData;
}

-(HuongdanModel *)modelxoSo {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn chơi xổ số";
    model.arrNameImage = @[];
    return model;
}

-(HuongdanModel *)modeltaikhoan {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn nạp tài khoản";
    model.arrNameImage = @[];
    return model;
}
-(HuongdanModel *)modelthaoluan {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn thảo luận";
    model.arrNameImage = @[];
    return model;
}

-(HuongdanModel *)modelthongke {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn thống kê";
    model.arrNameImage = @[];
    return model;
}

-(HuongdanModel *)modelxemKQXS {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn xem KQXS online - offline";
    model.arrNameImage = @[];
    return model;
}

-(HuongdanModel *)modeldangnhap {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn đăng nhập";
    model.arrNameImage = @[];
    return model;
}

-(HuongdanModel *)modeldangki {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn đăng kí";
    model.arrNameImage = @[];
    return model;
}

-(HuongdanModel *)modelchucnangtaikhoan {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn chức năng tài khoản";
    model.arrNameImage = @[];
    return model;
}

-(HuongdanModel *)modelchucnanggiaimong {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn chức năng giải mộng";
    model.arrNameImage = @[];
    return model;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
