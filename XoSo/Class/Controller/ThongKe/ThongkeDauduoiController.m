//
//  ThongkeDauduoiController.m
//  XoSo
//
//  Created by Khoa Le on 8/7/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeDauduoiController.h"
#import "CustomSegment.h"
#import "Province.h"
#import <NSManagedObject+GzDatabase.h>
#import "ThongkeDetailCell.h"
#import "TableListItem.h"
#import "ThongkeStore.h"
#import "ThongkeChuaVeModel.h"
#import "ThongkeDauduoiHeader.h"

static NSInteger const maxWidthpercentView = 190;
@interface ThongkeDauduoiController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UIButton *buttonLuotquay;
@property (weak, nonatomic) IBOutlet CustomSegment *segmentType;
@property (strong, nonatomic) TableListItem *tableListItem;
@property (strong, nonatomic) TableListItem *tableSoluong;
@property (assign, nonatomic) NSInteger selectIndex;
@property (assign, nonatomic) NSInteger matinh, luotquay;
@property (strong, nonatomic) NSArray *arrData;

- (IBAction)SelectCity:(UIButton *)sender;
- (IBAction)SelectLuotQuay:(UIButton *)sender;
- (IBAction)SelectType:(CustomSegment *)sender;
@end

@implementation ThongkeDauduoiController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Thống kê đầu đuôi";
    [self.tableView registerClass:[ThongkeDetailCell class] forCellReuseIdentifier:NSStringFromClass([ThongkeDetailCell class])];
    [self.tableView registerClass:[ThongkeDauduoiHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ThongkeDauduoiHeader class])];

    self.tableView.tableFooterView = [UIView new];

    self.matinh = 1;
    self.luotquay = 10;

    [self getDataForView];

    // Do any additional setup after loading the view from its nib.
}

- (void)getDataForView {
    NSString *xem;
    if (self.selectIndex == 0) {
        xem = thong_ke_dau;
    }
    else {
        xem = thong_ke_duoi;
    }
    [ThongkeStore thongkeDauDuoiWithLuotQuay:self.luotquay MaTinh:self.matinh Xem:xem Type:thong_ke_type_dac_biet Done: ^(BOOL success, NSArray *arr) {
        NSMutableArray *arrAll = [NSMutableArray new];
        if (success) {
            ThongkeChuaVeModel *model = [ThongkeChuaVeModel new];
            model.loaithongke = @"Đặc biệt";
            model.loai = LoaiThongKeDacbiet;
            model.arrThongke = arr;
            [arrAll addObject:model];
        }

        [ThongkeStore thongkeDauDuoiWithLuotQuay:self.luotquay MaTinh:self.matinh Xem:xem Type:thong_ke_type_loto Done: ^(BOOL success, NSArray *arrLoto) {
            if (success) {
                ThongkeChuaVeModel *lotomodel = [ThongkeChuaVeModel new];
                lotomodel.loaithongke = @"Lô tô";
                lotomodel.loai = LoaiThongKeLoto;
                lotomodel.arrThongke = arrLoto;
                [arrAll addObject:lotomodel];
            }
            self.arrData = arrAll;
            [self.tableView reloadData];
        }];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ThongkeDauduoiHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ThongkeDauduoiHeader class])];
    if (!header) {
        header = [[ThongkeDauduoiHeader alloc] initWithReuseIdentifier:NSStringFromClass([ThongkeDauduoiHeader class])];

    }
    header.contentView.backgroundColor = [UIColor whiteColor];

    ThongkeChuaVeModel *model = self.arrData[section];
    if (model.loai == LoaiThongKeDacbiet) {
        header.labelDacbiet.textColor = [UIColor redColor];
        header.labelSolanduocchon.textColor = [UIColor redColor];
    }
    else {
        header.labelDacbiet.textColor = [UIColor colorWithRed:125.0/255.0 green:174.0/255.0 blue:166.0/255.0 alpha:1.0];
        header.labelSolanduocchon.textColor = [UIColor colorWithRed:125.0/255.0 green:174.0/255.0 blue:166.0/255.0 alpha:1.0];
    }
    header.labelDacbiet.text = model.loaithongke;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.arrData[section] arrThongke] count];
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
    ThongkeChuaVeModel *model = self.arrData[indexPath.section];
    ThongkeCapSoModel *capso = model.arrThongke[indexPath.row];
    if (model.loai == LoaiThongKeDacbiet) {
        cell.labelNumber.text = capso.dacbiet;
        cell.labelPercent.text = [NSString stringWithFormat:@"%@%% (%@ lần)", capso.phan_tram, capso.so_lan_xh];
        cell.contraint_W_PercentView.constant = [capso.phan_tram integerValue] * maxWidthpercentView / 100  + 10;
        cell.labelNumber.backgroundColor = [UIColor colorWithRed:201.0 / 255.0 green:45.0 / 255.0 blue:42.0 / 255.0 alpha:1.0];
        cell.viewShowPercent.backgroundColor = [UIColor colorWithRed:243.0 / 255.0 green:138.0 / 255.0 blue:4.0 / 255.0 alpha:1.0];
    }
    else {
        cell.labelNumber.backgroundColor = [UIColor colorWithRed:40.0 / 255.0 green:119.0 / 255.0 blue:98.0 / 255.0 alpha:1.0];
        cell.viewShowPercent.backgroundColor = [UIColor colorWithRed:62.0 / 255.0 green:191.0 / 255.0 blue:57.0 / 255.0 alpha:1.0];
        cell.labelNumber.text = capso.loto;
        cell.labelPercent.text = [NSString stringWithFormat:@"%@%% (%@ lần)", capso.phan_tram, capso.so_lan_xh];
        cell.contraint_W_PercentView.constant = [capso.phan_tram integerValue] * maxWidthpercentView / 100  + 10;
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)SelectType:(CustomSegment *)sender {

    if (sender.selectedSegmentIndex == self.selectIndex) {
        return;
    }



    self.selectIndex = sender.selectedSegmentIndex;

    [self getDataForView];
}

@end
