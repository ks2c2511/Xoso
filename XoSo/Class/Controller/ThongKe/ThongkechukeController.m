//
//  ThongkechukeController.m
//  XoSo
//
//  Created by Khoa Le on 8/9/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkechukeController.h"
#import "ThongkechukiCell.h"
#import "ThongkechukiHeader.h"
#import "ThongkeStore.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
#import "TableListItem.h"
#import "Province.h"
#import <NSManagedObject+GzDatabase.h>

@interface ThongkechukeController ()
@property (weak, nonatomic) IBOutlet UITextField *textfieldCapso;
@property (weak, nonatomic) IBOutlet UIButton *buttonXemthongke;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *arrData;
@property (assign,nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger matinh;
@property (strong, nonatomic) TableListItem *tableListItem;
@end

@implementation ThongkechukeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Thống kê chu kì";
    // Do any additional setup after loading the view from its nib.
    
    self.buttonXemthongke.layer.borderColor = [UIColor colorWithRed:186.0/255.0 green:163.0/255.0 blue:92.0/255.0 alpha:1.0].CGColor;
    self.buttonXemthongke.layer.borderWidth = 2.0;
    self.buttonXemthongke.layer.cornerRadius = 6.0;
    self.buttonXemthongke.layer.masksToBounds = YES;
    
    self.textfieldCapso.layer.borderColor = [UIColor colorWithRed:186.0/255.0 green:163.0/255.0 blue:92.0/255.0 alpha:1.0].CGColor;
    self.textfieldCapso.layer.borderWidth = 2.0;
    self.textfieldCapso.layer.cornerRadius = 6.0;
    self.textfieldCapso.layer.masksToBounds = YES;
    
    self.buttonCity.layer.cornerRadius = 6.0;
    self.buttonCity.layer.masksToBounds = YES;
    
    self.imageBackGround.hidden = YES
    ;
    
    [self.tableView registerClass:[ThongkechukiCell class] forCellReuseIdentifier:NSStringFromClass([ThongkechukiCell class])];
    [self.tableView registerClass:[ThongkechukiHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ThongkechukiHeader class])];
    
    self.page = 1;
    self.matinh = 1;
    [ThongkeStore thongkeChukiLotoWithCapso:0 MaTinh:self.matinh Page:self.page Done:^(BOOL success, NSArray *arr) {
        
        self.arrData = [arr mutableCopy];
        [self.tableView reloadData];
    }];
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.triggerVerticalOffset = 10;
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.attributedTitle = [[NSAttributedString alloc]
                                      initWithString:@"Load more..."
                                      attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    [refreshControl addTarget:self
                       action:@selector(refresh:)
             forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl = refreshControl;
    
}

- (void)refresh:(UIRefreshControl *)ref {
    
    _page += 1;
    [ThongkeStore thongkeChukiLotoWithCapso:[self.textfieldCapso.text integerValue] MaTinh:self.matinh Page:self.page Done:^(BOOL success, NSArray *arr) {
        
        [self.arrData addObjectsFromArray:arr];
        [self.tableView reloadData];
        
        [ref endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ThongkechukiHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ThongkechukiHeader class])];
    if (!header) {
        header = [[ThongkechukiHeader alloc] initWithReuseIdentifier:NSStringFromClass([ThongkechukiHeader class])];
    }
    header.contentView.backgroundColor = [UIColor whiteColor];
    
       return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThongkechukiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkechukiCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(ThongkechukiCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIColor *color;
    if (indexPath.row %2 == 0) {
        color = [UIColor colorWithRed:237.0/255.0 green:227.0/255.0 blue:197.0/255.0 alpha:1.0];
    }
    else {
        color = [UIColor colorWithRed:242.0/255.0 green:218.0/255.0 blue:144.0/255.0 alpha:1.0];
    }
    
    cell.labelChuki.backgroundColor = color;
    cell.labelNgay.backgroundColor = color;
    
    ThongkeChuki *model = self.arrData[indexPath.row];
    
    cell.labelChuki.text = model.count;
    cell.labelNgay.text = model.date;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
           
        }];
        
        [self.view addSubview:_tableListItem];
    }
    
    return _tableListItem;
}

-(NSMutableArray *)arrData {
    if (!_arrData) {
        _arrData = [NSMutableArray new];
    }
    return _arrData;
}
- (IBAction)XemThongKe:(id)sender {
    
    self.page = 1;
    [ThongkeStore thongkeChukiLotoWithCapso:[self.textfieldCapso.text integerValue] MaTinh:self.matinh Page:self.page Done:^(BOOL success, NSArray *arr) {
        
        self.arrData = [arr mutableCopy];
        [self.tableView reloadData];
    }];

    
    
}
- (IBAction)ChonTinh:(id)sender {
    self.tableListItem.frame = ({
        CGRect frame = self.buttonCity.frame;
        frame.origin.y = CGRectGetMaxY(self.buttonCity.frame);
        frame.size.width = CGRectGetWidth(self.buttonCity.frame);
        frame.size.height = [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.buttonCity.frame) - HeightNavigationBar;
        frame;
    });
    [self.tableListItem showOrHiden];
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
