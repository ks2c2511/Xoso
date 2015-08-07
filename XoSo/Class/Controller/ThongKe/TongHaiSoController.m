//
//  TongHaiSoController.m
//  XoSo
//
//  Created by Khoa Le on 8/7/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.

#import "TongHaiSoController.h"
#import "ThongkeDetailCell.h"
#import "CustomSegment.h"
#import "Province.h"
#import <NSManagedObject+GzDatabase.h>
#import "TableListItem.h"
#import "ThongkeStore.h"
//#import "ThongkeChuaVeModel.h"
#import "ThongkeDauduoiHeader.h"

static NSInteger const maxWidthpercentView = 190;
@interface TongHaiSoController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UIButton *buttonLuotquay;
@property (strong, nonatomic) TableListItem *tableListItem;
@property (strong, nonatomic) TableListItem *tableSoluong;
@property (assign, nonatomic) NSInteger matinh, luotquay;
@property (strong, nonatomic) NSArray *arrData;


- (IBAction)SelectCity:(UIButton *)sender;
- (IBAction)SelectLuotQuay:(UIButton *)sender;
@end

@implementation TongHaiSoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Thống kê đầu đuôi";
    [self.tableView registerClass:[ThongkeDetailCell class] forCellReuseIdentifier:NSStringFromClass([ThongkeDetailCell class])];
    [self.tableView registerClass:[ThongkeDauduoiHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ThongkeDauduoiHeader class])];

    self.tableView.tableFooterView = [UIView new];

    self.matinh = 1;
    self.luotquay = 10;

    [self getDataForView];
}

- (void)getDataForView {
    [ThongkeStore thongkeHaiSoCuoiWithLuotQuay:self.luotquay MaTinh:self.matinh Done:^(BOOL success, NSArray *arr) {
        if (success) {
            self.arrData = arr;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ThongkeDauduoiHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ThongkeDauduoiHeader class])];
    if (!header) {
        header = [[ThongkeDauduoiHeader alloc] initWithReuseIdentifier:NSStringFromClass([ThongkeDauduoiHeader class])];
    }
    header.contentView.backgroundColor = [UIColor whiteColor];

        header.labelDacbiet.textColor = [UIColor redColor];
        header.labelSolanduocchon.textColor = [UIColor redColor];
      header.labelDacbiet.text = @"Mã lô tô";
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThongkeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeDetailCell class]) forIndexPath:indexPath];

    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(ThongkeDetailCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *dic = self.arrData[indexPath.row];
    NSString *soluong = [dic objectForKey:[NSString stringWithFormat:@"tong%i",(int)indexPath.row]];

        cell.labelNumber.text = [NSString stringWithFormat:@"%d",indexPath.row];
        cell.labelPercent.text = [NSString stringWithFormat:@"%@ lần", soluong];

        cell.contraint_W_PercentView.constant = 10;
    cell.viewShowPercent.hidden = YES;
        cell.labelNumber.backgroundColor = [UIColor colorWithRed:201.0 / 255.0 green:45.0 / 255.0 blue:42.0 / 255.0 alpha:1.0];
        cell.viewShowPercent.backgroundColor = [UIColor colorWithRed:243.0 / 255.0 green:138.0 / 255.0 blue:4.0 / 255.0 alpha:1.0];

    cell.viewContainNumber.backgroundColor = [UIColor colorWithRed:221.0 / 255.0 green:221.0 / 255.0 blue:221.0 / 255.0 alpha:1.0];
    cell.viewContainpercent.backgroundColor = [UIColor colorWithRed:221.0 / 255.0 green:221.0 / 255.0 blue:221.0 / 255.0 alpha:1.0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (TableListItem *)tableListItem {
    if (!_tableListItem) {
        _tableListItem = [[TableListItem alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableListItem.arrData = [Province fetchAll];
        [_tableListItem setTableViewCellConfigBlock: ^(TableListCell *cell, Province *pro) {
            cell.labelTttle.text = pro.province_name;
            if (self.matinh == [pro.province_id integerValue]) {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_checked_white.png"]];
            }
            else {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_unchecked_white.png"]];
            }
        }];

        __weak typeof(self) weakSelf = self;

        [_tableListItem setSelectItem: ^(NSIndexPath *indexPath, Province *pro) {
            [weakSelf.buttonCity setTitle:pro.province_name forState:UIControlStateNormal];
            weakSelf.matinh = [pro.province_id integerValue];

            [weakSelf.tableListItem reloadData];
            [weakSelf getDataForView];
        }];

        [self.view addSubview:_tableListItem];
    }

    return _tableListItem;
}

- (TableListItem *)tableSoluong {
    if (!_tableSoluong) {
        _tableSoluong = [[TableListItem alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableSoluong.arrData = @[@"10", @"20", @"30", @"60", @"100", @"365"];
        [_tableSoluong setTableViewCellConfigBlock: ^(TableListCell *cell, NSString *number) {
            cell.labelTttle.text = number;
            if (self.luotquay == [number integerValue]) {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_checked_white.png"]];
            }
            else {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_unchecked_white.png"]];
            }
        }];

        __weak typeof(self) weakSelf = self;

        [_tableSoluong setSelectItem: ^(NSIndexPath *indexPath, NSString *number) {
            [weakSelf.buttonLuotquay setTitle:number forState:UIControlStateNormal];
            weakSelf.luotquay = [number integerValue];

            [weakSelf.tableSoluong reloadData];
            [weakSelf getDataForView];
        }];

        [self.view addSubview:_tableSoluong];
    }

    return _tableSoluong;
}

- (IBAction)SelectCity:(UIButton *)sender {
    self.tableListItem.frame = ({
        CGRect frame = self.buttonCity.frame;
        frame.origin.y = CGRectGetMaxY(self.buttonCity.frame);
        frame.size.width = CGRectGetWidth(self.buttonCity.frame);
        frame.size.height = [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.buttonCity.frame) - HeightNavigationBar;
        frame;
    });
    [self.tableListItem showOrHiden];
}

- (IBAction)SelectLuotQuay:(UIButton *)sender {
    self.tableSoluong.frame = ({
        CGRect frame = self.buttonLuotquay.frame;
        frame.origin.x = CGRectGetMinX(self.buttonLuotquay.frame) - 50;
        frame.origin.y = CGRectGetMaxY(self.buttonLuotquay.frame);
        frame.size.width = CGRectGetWidth(self.buttonLuotquay.frame) + 50;
        frame.size.height = 250;
        frame;
    });
    [self.tableSoluong showOrHiden];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
