//
//  XemKQXSController.m
//  XoSo
//
//  Created by Khoa Le on 7/5/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "XemKQXSController.h"
#import "KetquaXosoMainCell.h"
#import "LotoDauDuoiCell.h"
#import "NameXosoCityHeader.h"
#import "LotoDauDuoiHeader.h"
#import "XemKQXSStore.h"
#import "UIColor+AppTheme.h"
#import <ActionSheetDatePicker.h>
#import "TableListItem.h"
#import "Province.h"
#import <NSManagedObject+GzDatabase.h>

typedef NS_ENUM(NSInteger, ListType) {
    ListTypeXoSo,
    ListTypeLoTo
};

static NSString *const identifi_KetquaXosoMainCell = @"identifi_KetquaXosoMainCell";
static NSString *const identifi_LotoDauDuoiCell = @"identifi_LotoDauDuoiCell";
static NSString *const identifi_NameXosoCityHeader = @"identifi_NameXosoCityHeader";
static NSString *const identifi_LotoDauDuoiHeader = @"identifi_LotoDauDuoiHeader";
@interface XemKQXSController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonChonngay;
@property (weak, nonatomic) IBOutlet UILabel *labelNameCity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) TableListItem *tableListItem;
@property (strong,nonatomic)NSArray *arrData;
@property (weak, nonatomic) IBOutlet UIView *containnerViewHeader;

@property (strong,nonatomic) NSDateFormatter *dateFormat;
@property (strong,nonatomic) NSString *selectDate;
@property (assign,nonatomic) NSInteger companyId;
@end

@implementation XemKQXSController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Province fetchEntityObjectsWithPredicate:[NSPredicate predicateWithFormat:@"province_id == 1"] success:^(BOOL succeeded, NSArray *objects) {
        if (objects.count !=0) {
            Province *pro = objects[0];
            self.labelNameCity.text = pro.province_name;
            self.companyId = [pro.province_id integerValue];
            [self LoadData];
        }
    }];
    
    [self.tableView registerClass:[KetquaXosoMainCell class] forCellReuseIdentifier:identifi_KetquaXosoMainCell];
    [self.tableView registerClass:[LotoDauDuoiCell class] forCellReuseIdentifier:identifi_LotoDauDuoiCell];
    [self.tableView registerClass:[NameXosoCityHeader class] forHeaderFooterViewReuseIdentifier:identifi_NameXosoCityHeader];
    [self.tableView registerClass:[LotoDauDuoiHeader class] forHeaderFooterViewReuseIdentifier:identifi_LotoDauDuoiHeader];
    
    self.containnerViewHeader.layer.borderColor = [UIColor appVioletNavigationBarColor].CGColor;
    self.containnerViewHeader.layer.borderWidth = 3.0;
    
        // Do any additional setup after loading the view from its nib.
    
}

-(void)LoadData {
    
    
    [XemKQXSStore GetResultByDateWithDate:self.selectDate CompanyId:@(self.companyId) Done:^(BOOL success, NSArray *arr) {
        NSMutableArray *muArr = [NSMutableArray new];
        if (arr.count != 0) {
            [muArr addObject:[self dicWithArray:arr ListType:ListTypeXoSo]];
        }
        
        self.arrData = muArr;
        muArr = nil;
        [self.tableView reloadData];
    }];

}
-(NSDictionary *)dicWithArray:(NSArray *)arr ListType:(ListType)listtype {
    return @{@"array": arr,@"listtype":@(listtype)};
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30.0;
    }
    return 100.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NameXosoCityHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifi_NameXosoCityHeader];
        if (!header) {
            header = [[NameXosoCityHeader alloc] initWithReuseIdentifier:identifi_NameXosoCityHeader];
            header.contentView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
        }
        
        return header;
    }
    else {
        LotoDauDuoiHeader *header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifi_LotoDauDuoiHeader];
        if (!header) {
            header = [[LotoDauDuoiHeader alloc] initWithReuseIdentifier:identifi_LotoDauDuoiHeader];
        }
        return header;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.arrData[section][@"array"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.arrData[indexPath.section][@"listtype"] integerValue] == ListTypeXoSo) {
        return 44;
    }
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.arrData[indexPath.section][@"listtype"] integerValue] == ListTypeXoSo) {
        KetquaXosoMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifi_KetquaXosoMainCell forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (indexPath.row == 0) {
            cell.labelNumber.text = [NSString stringWithFormat:@"Đặc biệt"];
            cell.labelNumber.textColor = [UIColor appOrange];
            cell.labelResult.textColor = [UIColor redColor];
            cell.labelResult.text = [NSString stringWithFormat:@"%@",[self.arrData[indexPath.section][@"array"][indexPath.row] RESULT_NUMBER]];
        }
        else {
            cell.labelNumber.text = [NSString stringWithFormat:@"%@",[self.arrData[indexPath.section][@"array"][indexPath.row] PRIZE_ID]];
            cell.labelNumber.textColor = [UIColor whiteColor];
            cell.labelResult.textColor = [UIColor blackColor];
            cell.labelResult.text = [NSString stringWithFormat:@"%@",[self.arrData[indexPath.section][@"array"][indexPath.row] RESULT_NUMBER]];
        }
        
        return cell;
    }
    else {
        LotoDauDuoiCell *cell = [tableView dequeueReusableCellWithIdentifier:identifi_LotoDauDuoiCell forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
   
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
- (IBAction)selectCity:(id)sender {
    
    self.tableListItem.frame = ({
        CGRect frame = self.labelNameCity.frame;
        frame.origin.y = CGRectGetMaxY(self.labelNameCity.frame);
        frame.size.width = CGRectGetWidth(self.labelNameCity.frame);
        frame.size.height = [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.labelNameCity.frame) - HeightNavigationBar;
        frame;
    });
    [self.tableListItem showOrHiden];
}

-(NSDateFormatter *)dateFormat {
    if (!_dateFormat) {
        _dateFormat = [NSDateFormatter new];
        [_dateFormat setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormat;
}
- (IBAction)SelectDate:(UIButton *)sender {
    
  
    [ActionSheetDatePicker showPickerWithTitle:@"Chọn ngày" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        
        self.selectDate = [self.dateFormat stringFromDate:(NSDate *)selectedDate];
        
        [self LoadData];
        
        
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
        
        
    } origin:self.view];
}

-(NSString *)selectDate {
    if (!_selectDate) {
        _selectDate = [self.dateFormat stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24]];
    }
    return _selectDate;
}

-(TableListItem *)tableListItem {
    if (!_tableListItem) {
        _tableListItem = [[TableListItem alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableListItem.arrData = [Province fetchAll];
        [_tableListItem setTableViewCellConfigBlock:^(TableListCell *cell ,Province *pro) {
            cell.labelTttle.text = pro.province_name;
            if (self.companyId == [pro.province_id integerValue]) {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_checked_white.png"]];
            }
            else {
                 [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_unchecked_white.png"]];
            }
        }];
        __weak typeof(self)weakSelf = self;
        [_tableListItem setSelectItem:^(NSIndexPath *indexPath, Province *pro) {
            weakSelf.labelNameCity.text = pro.province_name;
            weakSelf.companyId = [pro.province_id integerValue];
           
            [weakSelf.tableListItem reloadData];
            [weakSelf LoadData];
        }];
        
        [self.view addSubview:_tableListItem];
    }
    
    return _tableListItem;
}

- (IBAction)RightSwipe:(UISwipeGestureRecognizer *)sender {
    
    [UIView transitionWithView:self.tableView
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        
                        
                    } completion:nil];
}

- (IBAction)LeftSwipe:(UISwipeGestureRecognizer *)sender {
    
    [UIView transitionWithView:self.tableView
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                        
                        
                     
                    } completion:nil];
}


@end
