//
//  ThongkeUserController.m
//  XoSo
//
//  Created by Khoa Le on 8/9/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeUserController.h"
#import "ButtonSelect.h"
#import "ThongkeUserCell.h"
#import "ThongkeUserHeader.h"
#import "ThongkeTopUserCell.h"
#import "ThongKeTopUserFooter.h"
#import "ThongkeStore.h"
#import <UIAlertView+Blocks.h>
typedef NS_ENUM(NSInteger, TopUSer) {
    TopUSerDiemCao,
    TopUSerTrungCao
};

@interface ThongkeUserController ()
@property (weak, nonatomic) IBOutlet ButtonSelect *buttonDiemcao;
@property (weak, nonatomic) IBOutlet ButtonSelect *buttonTrungcao;
@property (weak, nonatomic) IBOutlet UITextField *textfieldTungay;
@property (weak, nonatomic) IBOutlet UITextField *textDenngay;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contraint_H_Chonngay;
@property (strong,nonatomic) NSArray *arrData;
@property (assign,nonatomic) TopUSer userTop;
@property (strong,nonatomic) NSString *nameUser,*leverUser,*pointUser;
@property (assign,nonatomic) NSInteger numberDay;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) NSDateFormatter *dateFormatter;

- (IBAction)ChonDiemCao:(id)sender;
- (IBAction)ChonTrungCao:(id)sender;

@end

@implementation ThongkeUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"TOP người chơi";
    
    [self.tableView registerClass:[ThongkeUserCell class] forCellReuseIdentifier:NSStringFromClass([ThongkeUserCell class])];
    [self.tableView registerClass:[ThongkeUserHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ThongkeUserHeader class])];
    [self.tableView registerClass:[ThongkeTopUserCell class] forCellReuseIdentifier:NSStringFromClass([ThongkeTopUserCell class])];
    [self.tableView registerClass:[ThongKeTopUserFooter class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ThongKeTopUserFooter class])];
    
    self.imageBackGround.hidden = YES;
    
    self.textfieldTungay.layer.borderColor = [UIColor colorWithRed:174.0/255.0 green:148.0/255.0 blue:71.0/255.0 alpha:1.0].CGColor;
    self.textfieldTungay.layer.borderWidth = 2.0;
    self.textfieldTungay.layer.cornerRadius = 6.0;
    self.textfieldTungay.layer.masksToBounds = YES;
    self.textfieldTungay.inputView = self.datePicker;
    self.textfieldTungay.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-7*24*60*60]];
    
    self.textDenngay.layer.borderColor = [UIColor colorWithRed:174.0/255.0 green:148.0/255.0 blue:71.0/255.0 alpha:1.0].CGColor;
    self.textDenngay.layer.borderWidth = 2.0;
    self.textDenngay.layer.cornerRadius = 6.0;
    self.textDenngay.layer.masksToBounds = YES;
    self.textDenngay.text = [self.dateFormatter stringFromDate:[NSDate date]];
    
    self.textDenngay.inputView = self.datePicker;
    
    self.buttonDiemcao.isSelect = YES;
    
    self.numberDay = [self numberDayWithFromDay:[NSDate dateWithTimeIntervalSinceNow:-7*24*60*60] ToDay:[NSDate date]];
    
    [self LoadData];
    
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)numberDayWithFromDay:(NSDate *)from ToDay:(NSDate *)to {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:from
                                                          toDate:to
                                                         options:0];
    return components.day;
}

-(void)LoadData {
    if (self.userTop == TopUSerTrungCao) {
        [ThongkeStore thongkeUserTrungCaoWithFromDate:self.textfieldTungay.text ToDate:self.textDenngay.text Done:^(BOOL success, NSArray *arr) {
            if (success) {
            
                self.arrData = arr;
                [self.tableView reloadData];
            }
            else {
                self.arrData = nil;
                [self.tableView reloadData];
            }
        }];
    }
    else {
        [ThongkeStore thongkeUserDiemCaoWithType:1 Done:^(BOOL success, NSArray *arr, NSString *pointUser, NSString *leverUser, NSString *nameUser) {
            if (success) {
                
                self.arrData = arr;
                _nameUser = nameUser;
                _pointUser = pointUser;
                _leverUser = leverUser;
                
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - Textfield Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
   
        textField.text = [self.dateFormatter stringFromDate:self.datePicker.date];
    
    self.numberDay = [self numberDayWithFromDay:[self.dateFormatter dateFromString:self.textfieldTungay.text] ToDay:[self.dateFormatter dateFromString:self.textDenngay.text]];
    if (self.numberDay < 0) {
        UIAlertView *alert = [UIAlertView showWithTitle:@"Lỗi" message:@"Chọn lại khoảng ngày." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        [alert show];
    }
    else {
        [self LoadData];
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.userTop == TopUSerTrungCao) {
        ThongkeUserHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ThongkeUserHeader class])];
        if (!header) {
            header = [[ThongkeUserHeader alloc] initWithReuseIdentifier:NSStringFromClass([ThongkeUserHeader class])];
        }
        header.contentView.backgroundColor = [UIColor whiteColor];
        
        return header;
    }
    return nil;
   
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.userTop == TopUSerDiemCao) {
        ThongKeTopUserFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ThongKeTopUserFooter class])];
        if (!footer) {
            footer = [[ThongKeTopUserFooter alloc] initWithReuseIdentifier:NSStringFromClass([ThongKeTopUserFooter class])];
        }
        footer.labelName.text = [NSString stringWithFormat:@"%@",self.nameUser];
        footer.labelPoint.text = [NSString stringWithFormat:@"%@",self.pointUser];
        footer.labelStt.text = [NSString stringWithFormat:@"%@",self.leverUser];
        
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.userTop == TopUSerTrungCao) {
        return 30;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.userTop == TopUSerDiemCao) {
        return 30;
    }
    return 0;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    if (self.userTop == TopUSerTrungCao) {
        static ThongkeUserCell *sizingCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sizingCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeUserCell class])];
        });
        [self configureCell:sizingCell forRowAtIndexPath:indexPath];
        
        return [self calculateHeightForConfiguredSizingCell:sizingCell];
    }
    else {
        static ThongkeTopUserCell *sizingCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sizingCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeTopUserCell class])];
        });
        [self configureCell:sizingCell forRowAtIndexPath:indexPath];
        
        return [self calculateHeightForConfiguredSizingCell:sizingCell];
    }
    
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (IS_IOS8) {
    //        return UITableViewAutomaticDimension;
    //    }
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.userTop == TopUSerTrungCao) {
        ThongkeUserCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeUserCell class]) forIndexPath:indexPath];
        
        [self configureCell:cell forRowAtIndexPath:indexPath];
        cell.tag = indexPath.row;
        
        return cell;
    }
    else {
        ThongkeTopUserCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeTopUserCell class]) forIndexPath:indexPath];
        
        [self configureCell:cell forRowAtIndexPath:indexPath];
        
        return cell;
    }
}

- (void)configureCell:(id )cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.userTop == TopUSerTrungCao) {
        ThongkeTrungcaoModel *model = self.arrData[indexPath.row];
        ThongkeUserCell *usercell = cell;
        usercell.labelName.text = model.username;
        usercell.labelTrung.text = [NSString stringWithFormat:@"%@",model.trung];
        usercell.labelTong.text = [NSString stringWithFormat:@"%ld",(long)self.numberDay];
        usercell.labelTileTrung.text = [NSString stringWithFormat:@"%@/%@",usercell.labelTrung.text,usercell.labelTong.text];
    }
    else {
        ThongKeDiemCaoModel *model = self.arrData[indexPath.row];
        ThongkeTopUserCell *topCell = (ThongkeTopUserCell *)cell;
        topCell.labelStt.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
        topCell.labelName.text = [NSString stringWithFormat:@"%@",model.username];
        topCell.labelPoint.text = [NSString stringWithFormat:@"%@",model.sumpoint];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ChonDiemCao:(id)sender {
    
    self.buttonDiemcao.isSelect = YES;
    self.buttonTrungcao.isSelect = NO;
    self.contraint_H_Chonngay.constant = 0;
    self.userTop = TopUSerDiemCao;
    
    [self LoadData];
}

- (IBAction)ChonTrungCao:(id)sender {
    
    self.buttonDiemcao.isSelect = NO;
    self.buttonTrungcao.isSelect = YES;
    self.contraint_H_Chonngay.constant = 70;
    self.userTop = TopUSerTrungCao;
    
    [self LoadData];
}

#pragma mark -Date picker
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.maximumDate = [NSDate date];
        _datePicker.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    
    return _datePicker;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormatter;
}

@end
