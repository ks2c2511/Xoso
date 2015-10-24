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
#import <GzInternetConnection.h>
#import <UIAlertView+Blocks.h>
#import "NSDate+Category.h"

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
@property (strong,nonatomic) ActionSheetDatePicker *datePicker;
@property (strong,nonatomic) NSDateFormatter *dateFormat,*dateFormatShow;
@property (strong,nonatomic) NSString *selectDate;
@property (assign,nonatomic) NSInteger companyId;
@property (assign,nonatomic) NSInteger khoangcach;
@property (assign,nonatomic) NSInteger quayTruocOrSau;

//@property (strong,nonatomic) NSString *maxDate;
@end

@implementation XemKQXSController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Kết quả xổ số";
    
//    self.maxDate = [NSDate date];

    [[GzInternetConnection ShareIntance] CheckInternetStatusWithsuccess:^(BOOL Status) {
        if (!Status) {
            [UIAlertView showWithTitle:@"Thông báo" message:@"Không có kết nối mạng. Ứng dụng sẽ hiển thị thông tin offline" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        }
    }];
    self.companyId = 1;
    
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
    
    [XemKQXSStore GetResultNearTimeWithMaTinh:@(self.companyId) SoLanQuay:1 Done:^(BOOL success, NSArray *arrKqsx, NSArray *arrLoto) {
        NSMutableArray *muArr = [NSMutableArray new];
        if (arrKqsx.count != 0) {
            XemKQXSModel *model = arrKqsx[0];
            self.selectDate = model.RESULT_DATE;
//            self.maxDate = model.RESULT_DATE;
            [self.datePicker setMaximumDate:[self.dateFormat dateFromString:self.selectDate]];
            [muArr addObject:[self dicWithArray:arrKqsx ListType:ListTypeXoSo]];
            [muArr addObject:[self dicWithArray:arrLoto ListType:ListTypeLoTo]];
        }
//        else {
//            [UIAlertView showWithTitle:@"Thông báo" message:@"Không thể lấy dữ liệu từ server." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
//        }
        
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
        return 40;
    }
    return 90;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NameXosoCityHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifi_NameXosoCityHeader];
        if (!header) {
            header = [[NameXosoCityHeader alloc] initWithReuseIdentifier:identifi_NameXosoCityHeader];
            header.contentView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
                  }
         header.labelTitle.text = [NSString stringWithFormat:@"%@, %@",self.labelNameCity.text,[self.dateFormatShow stringFromDate:[self.dateFormat dateFromString:self.selectDate]]];
        [header.buttonLeft addTarget:self action:@selector(RightSwipe:) forControlEvents:UIControlEventTouchUpInside];
        [header.buttonRight addTarget:self action:@selector(LeftSwipe:) forControlEvents:UIControlEventTouchUpInside];
        
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
        
        XemKQXSModel *xemMOdel = self.arrData[indexPath.section][@"array"][indexPath.row];
        if (indexPath.row == 0) {
            cell.labelNumber.text = [NSString stringWithFormat:@"Đặc biệt"];
            cell.labelNumber.textColor = [UIColor appOrange];
            cell.labelResult.textColor = [UIColor redColor];
            cell.labelResult.text = [NSString stringWithFormat:@"%@",[xemMOdel RESULT_NUMBER]];
        }
        else {
            cell.labelNumber.text = [NSString stringWithFormat:@"%@",[xemMOdel PRIZE_ID]];
            cell.labelNumber.textColor = [UIColor whiteColor];
            cell.labelResult.textColor = [UIColor blackColor];
            cell.labelResult.text = [NSString stringWithFormat:@"%@",[xemMOdel RESULT_NUMBER]];
        }
        
        return cell;
    }
    else {
        LotoDauDuoiCell *cell = [tableView dequeueReusableCellWithIdentifier:identifi_LotoDauDuoiCell forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        DauDuoiModel *xemMOdel = self.arrData[indexPath.section][@"array"][indexPath.row];
        cell.labelDauLeft.text = [NSString stringWithFormat:@"%li",(long)xemMOdel.gia_tri];
        cell.labelDuoiLeft.text = xemMOdel.duoi;
        
        cell.labelDuoiRight.text = [NSString stringWithFormat:@"%li",(long)xemMOdel.gia_tri];
        cell.labelDauRight.text = xemMOdel.dau;
        
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
        _dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        _dateFormat.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [_dateFormat setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormat;
}
- (IBAction)SelectDate:(UIButton *)sender {
    
    [self.datePicker showActionSheetPicker];
    
    
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

-(void)GetDataDiffrentDay {

    [XemKQXSStore GetResultByDateWithDate:self.selectDate CompanyId:@(self.companyId) Done:^(BOOL success, NSArray *arrKqsx, NSArray *arrLoto) {
        NSMutableArray *muArr = [NSMutableArray new];
                if (arrKqsx.count != 0) {
                    XemKQXSModel *model = arrKqsx[0];
                    self.selectDate = model.RESULT_DATE;
                    [muArr addObject:[self dicWithArray:arrKqsx ListType:ListTypeXoSo]];
                    [muArr addObject:[self dicWithArray:arrLoto ListType:ListTypeLoTo]];
                    
                    
                }
        self.arrData = muArr;
        

        if (self.arrData.count == 0) {
            [UIAlertView showWithTitle:@"Thông báo" message:@"Không có kết quả." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        }
        else {
           [self.tableView reloadData];
        }
//                muArr = nil;
//                [self.tableView reloadData];
    }];
}

-(void)GetDataWithScroll {
    [XemKQXSStore GetResultPreDayWithResultDate:self.selectDate MaTinh:[NSString stringWithFormat:@"%ld",self.companyId] Ckorder:self.quayTruocOrSau KhoangCachDenNgay:1 Done:^(BOOL success, NSArray *arrKqsx, NSArray *arrLoto) {
         NSMutableArray *muArr = [NSMutableArray new];
        if (arrKqsx.count != 0) {
            XemKQXSModel *model = arrKqsx[0];
            self.selectDate = model.RESULT_DATE;
            [muArr addObject:[self dicWithArray:arrKqsx ListType:ListTypeXoSo]];
            [muArr addObject:[self dicWithArray:arrLoto ListType:ListTypeLoTo]];
        }
        
        self.arrData = muArr;
        
        if (self.arrData.count == 0) {
            [UIAlertView showWithTitle:@"Thông báo" message:@"Không có kết quả." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        }
        muArr = nil;
        [self.tableView reloadData];
    }];
}

- (IBAction)RightSwipe:(UISwipeGestureRecognizer *)sender {
    
    self.quayTruocOrSau = 1;
    [UIView transitionWithView:self.tableView
                      duration:.5
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        self.khoangcach +=1;
                        
                        [self GetDataWithScroll];
                        
                    } completion:nil];
}

- (IBAction)LeftSwipe:(UISwipeGestureRecognizer *)sender {

    self.quayTruocOrSau = 2;
    
#if DEBUG
    NSLog(@"---log---> %li",(long)self.khoangcach);
#endif
    if (self.khoangcach <= 0) {

        [UIAlertView showWithTitle:@"Thông báo" message:@"Không có kết quả cho ngày kế tiếp." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return;
    }

    [UIView transitionWithView:self.tableView
                      duration:.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                        
                        self.khoangcach -=1;
                        
                        [self GetDataWithScroll];
                     
                    } completion:nil];
}

-(ActionSheetDatePicker *)datePicker {
    if (!_datePicker) {
        
        _datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Chọn ngày" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
            
            self.selectDate = [self.dateFormat stringFromDate:(NSDate *)selectedDate];
            
            [self GetDataDiffrentDay];
            
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            
        } origin:self.view];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        _datePicker.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    
    return _datePicker;
}

-(NSDateFormatter *)dateFormatShow {
    if (!_dateFormatShow) {
        _dateFormatShow = [NSDateFormatter new];
        _dateFormatShow.dateFormat = @"dd-MM-yyyy";
        _dateFormatShow.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return _dateFormatShow;
}
@end
