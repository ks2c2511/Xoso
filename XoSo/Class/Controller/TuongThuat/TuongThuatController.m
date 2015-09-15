//
//  TuongThuatController.m
//  XoSo
//
//  Created by Khoa Le on 7/26/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "TuongThuatController.h"
#import "TableBacOneCell.h"
#import "TableBacTwoCell.h"
#import "TableBacThreeCell.h"
#import "TableBacFourCell.h"
#import "TableSixCell.h"
#import "TableMIenTrungCell.h"
#import "TableMienNamCell.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "TuongthuatStore.h"
#import "CalendarData.h"
#import "NSDate+Category.h"
#import <UIAlertView+Blocks.h>
#import "CauVipController.h"
typedef NS_ENUM (NSInteger, TableType) {
    TableTypeMienBac = 1,
    TableTypeMienTrung = 2,
    TableTypeMienNam = 3
};

@interface TuongThuatController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonMIenbac;
@property (weak, nonatomic) IBOutlet UIButton *buttonMIenTrung;
@property (weak, nonatomic) IBOutlet UIButton *buttonMIennam;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong, nonatomic) NSArray *arrData;
@property (assign, nonatomic) TableType typeTableCell;
@property (assign,nonatomic) NSInteger numberProvince;
@property (assign,nonatomic) BOOL showPopUpPhangBac,showPopUpPhangTrung,showPopUpPhangNam;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indical;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentChonMien;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contraint_H_ViewThongbao;
@property (weak, nonatomic) IBOutlet UILabel *labelThongbao;
@end

@implementation TuongThuatController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberProvince = 3;
   
    self.navigationItem.title = @"Tường thuật trực tiếp";
    self.imageBackGround.hidden = YES;

    self.bannerView.adUnitID = google_id_Ad;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];

    [self.tableView registerClass:[TableBacOneCell class] forCellReuseIdentifier:NSStringFromClass([TableBacOneCell class])];
    [self.tableView registerClass:[TableBacTwoCell class] forCellReuseIdentifier:NSStringFromClass([TableBacTwoCell class])];
    [self.tableView registerClass:[TableBacThreeCell class] forCellReuseIdentifier:NSStringFromClass([TableBacThreeCell class])];
    [self.tableView registerClass:[TableBacFourCell class] forCellReuseIdentifier:NSStringFromClass([TableBacFourCell class])];
    [self.tableView registerClass:[TableSixCell class] forCellReuseIdentifier:NSStringFromClass([TableSixCell class])];
    [self.tableView registerClass:[TableMIenTrungCell class] forCellReuseIdentifier:NSStringFromClass([TableMIenTrungCell class])];
    [self.tableView registerClass:[TableMienNamCell class] forCellReuseIdentifier:NSStringFromClass([TableMienNamCell class])];


    
    if ([[NSDate date] hour] < 17) {
         self.typeTableCell = TableTypeMienNam;
    }
    else if ([[NSDate date] hour] >= 17 && [[NSDate date] hour] < 18) {
        self.typeTableCell = TableTypeMienTrung;
    }
    else {
        self.typeTableCell = TableTypeMienBac;
    }
    if (([[NSDate date] hour] < 16 || ([[NSDate date] hour] == 16 && [[NSDate date] minute] < 15)) && self.typeTableCell == TableTypeMienNam) {
        
        self.labelThongbao.text = @"Chưa có kết quả, mời bạn quay lại sau 16h15'";
        self.indical.hidden = YES;
        self.labelThongbao.hidden = NO;
        self.contraint_H_ViewThongbao.constant = 30;
        
    }
    else if ([[NSDate date] hour] == 16 && [[NSDate date] minute] >= 15 && [[NSDate date] minute] <= 30 && self.typeTableCell == TableTypeMienNam) {
        self.labelThongbao.text = @"Đang tường thuật xổ số miền Nam";
        self.indical.hidden = NO;
         [self.indical startAnimating];
        self.labelThongbao.hidden = NO;
        self.contraint_H_ViewThongbao.constant = 30;
    }
    else {
        
        self.labelThongbao.hidden = YES;
        self.indical.hidden = YES;
        self.contraint_H_ViewThongbao.constant = 0;
    }
}

- (void)loadDataRealTime {
    [self getTuongThuatWithMien:self.typeTableCell];
    NSInteger currentHour = [[NSDate date] hour];
    if (self.typeTableCell == TableTypeMienBac && currentHour >= 18 && currentHour <= 19) {
        [self performSelector:@selector(loadDataRealTime) withObject:nil afterDelay:1 * 10];
    }
    else if (self.typeTableCell == TableTypeMienTrung && currentHour >= 17 && currentHour <= 18) {
        [self performSelector:@selector(loadDataRealTime) withObject:nil afterDelay:1 * 10];
    }
    else if (self.typeTableCell == TableTypeMienNam && currentHour >= 16 && currentHour <= 17) {
        [self performSelector:@selector(loadDataRealTime) withObject:nil afterDelay:1 * 10];
    }
}

- (void)getTuongThuatWithMien:(TableType)type {
    [TuongthuatStore getTuongThuatTrucTiepWithMaMien:type Done: ^(BOOL success, NSArray *arr,NSInteger numberProvince) {
        if (success) {
            _numberProvince = numberProvince;
            _arrData = arr;
        }
        else {
            _arrData = nil;
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.typeTableCell == TableTypeMienBac) {
        return 8;
    }
    else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.typeTableCell == TableTypeMienBac) {
        if (indexPath.row == 3 || indexPath.row == 5) {
            return 60;
        }
        return 30;
    }
    else {
        if (indexPath.row == 3) {
            return 70;
        }
        else if (indexPath.row == 5) {
            return 130;
        }
        else if (indexPath.row == 6) {
            return 45;
        }
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TuongthuatConvertModel *modelConvert = self.arrData[indexPath.row];
//    array ket qua cuar moi tinh theo tung giai
    NSArray *arrKetqua = modelConvert.arr;
    NSArray *arrKetqua1 = modelConvert.arr1;
    NSArray *arrKetqua2 = modelConvert.arr2;
    NSArray *arrKetqua3 = modelConvert.arr3;
    
    if (self.typeTableCell == TableTypeMienBac) {
        UIColor *backGroudColor;
        if (indexPath.row % 2 == 0) {
            backGroudColor = [UIColor colorWithRed:250.0 / 255.0 green:255.0 / 255.0 blue:200.0 / 255.0 alpha:1.0];
        }
        else backGroudColor = [UIColor whiteColor];

        if (indexPath.row == 0 || indexPath.row == 1) {
            TableBacOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableBacOneCell class]) forIndexPath:indexPath];
            if (indexPath.row == 0) {
                cell.labelTitle.text = @"Đặc biệt";
                cell.labelTitle.textColor = [UIColor redColor];
                cell.labelNUmber.textColor = [UIColor redColor];
            }
            else {
                cell.labelTitle.text = @"Giải nhất";
                cell.labelTitle.textColor = [UIColor blackColor];
                cell.labelNUmber.textColor = [UIColor blackColor];
            }

            if (arrKetqua.count != 0) {
                cell.labelNUmber.text = [[arrKetqua firstObject] ket_qua];
            }
            else {
                cell.labelNUmber.text = @"...";
            }
            cell.labelTitle.backgroundColor = backGroudColor;
            cell.labelNUmber.backgroundColor = backGroudColor;

            return cell;
        }
        else if (indexPath.row == 2) {
            TableBacTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableBacTwoCell class]) forIndexPath:indexPath];
            cell.labelTitle.backgroundColor = backGroudColor;
            cell.labelNumber1.backgroundColor = backGroudColor;
            cell.labelNumber2.backgroundColor = backGroudColor;
            cell.labelTitle.text = @"Giải Nhì";
            cell.contraint_W_Label.constant = 72;

            if (arrKetqua.count == 2 && [[arrKetqua firstObject] isKindOfClass:[TuongthuatModel class]]) {
                cell.labelNumber1.text = [[arrKetqua firstObject] ket_qua];
                cell.labelNumber2.text = [[arrKetqua lastObject] ket_qua];
            }
            else {
                cell.labelNumber1.text = @"...";
                cell.labelNumber2.text = @"...";
            }

            return cell;
        }
        else if (indexPath.row == 3 || indexPath.row == 5) {
            TableSixCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableSixCell class]) forIndexPath:indexPath];
            cell.labelTitle.backgroundColor = backGroudColor;

            for (int i = 1; i <= 6; i++) {
                [(UILabel *)[cell.contentView viewWithTag:i] setBackgroundColor:backGroudColor];
                if (arrKetqua.count == 6 && [arrKetqua[i - 1] isKindOfClass:[TuongthuatModel class]]) {
                    [(UILabel *)[cell.contentView viewWithTag:i] setText:[arrKetqua[i - 1] ket_qua]];
                }
                else {
                    [(UILabel *)[cell.contentView viewWithTag:i] setText:@"..."];
                }
            }
            if (indexPath.row == 3) {
                cell.labelTitle.text = @"Giải Ba";
            }
            else {
                cell.labelTitle.text = @"Giải Năm";
            }

            return cell;
        }
        else if (indexPath.row == 4 || indexPath.row == 7) {
            TableBacFourCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableBacFourCell class]) forIndexPath:indexPath];

            cell.labelTitle.backgroundColor = backGroudColor;
            cell.contraint_W_Label.constant = 72;

            for (int i = 1; i < 5; i++) {
                [(UILabel *)[cell.contentView viewWithTag:i] setBackgroundColor:backGroudColor];
                if (arrKetqua.count == 4 && [arrKetqua[i - 1] isKindOfClass:[TuongthuatModel class]]) {
                    [(UILabel *)[cell.contentView viewWithTag:i] setText:[arrKetqua[i - 1] ket_qua]];
                }
                else {
                    [(UILabel *)[cell.contentView viewWithTag:i] setText:@"..."];
                }
            }
            if (indexPath.row == 4) {
                cell.labelTitle.text = @"Giải Tư";
            }
            else {
                cell.labelTitle.text = @"Giải Bảy";
            }


            return cell;
        }
        else if (indexPath.row == 6) {
            TableBacThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableBacThreeCell class]) forIndexPath:indexPath];

            cell.labelTitle.backgroundColor = backGroudColor;
            cell.contraint_W_Label.constant = 72;

            for (int i = 1; i < 4; i++) {
                [(UILabel *)[cell.contentView viewWithTag:i] setBackgroundColor:backGroudColor];
                if (arrKetqua.count == 3 && [arrKetqua[i - 1] isKindOfClass:[TuongthuatModel class]]) {
                    [(UILabel *)[cell.contentView viewWithTag:i] setText:[arrKetqua[i - 1] ket_qua]];
                }
                else {
                    [(UILabel *)[cell.contentView viewWithTag:i] setText:@"..."];
                }
            }
            cell.labelTitle.text = @"Giải Sáu";


            return cell;
        }
    }
    else {
        UIColor *backGroudColor;
        if (indexPath.row % 2 != 0) {
            backGroudColor = [UIColor colorWithRed:250.0 / 255.0 green:255.0 / 255.0 blue:200.0 / 255.0 alpha:1.0];
        }
        else backGroudColor = [UIColor whiteColor];
        
        if (self.numberProvince == 2) {
            TableBacTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableBacTwoCell class]) forIndexPath:indexPath];
            cell.contraint_W_Label.constant = 20;
            
            cell.labelTitle.backgroundColor = backGroudColor;
            cell.labelNumber1.backgroundColor = backGroudColor;
            cell.labelNumber2.backgroundColor = backGroudColor;
        
        cell.labelTitle.textColor = [UIColor blackColor];
        cell.labelNumber1.textColor = [UIColor blackColor];
        cell.labelNumber2.textColor = [UIColor blackColor];
            if (indexPath.row == 0) {
                cell.labelTitle.text = @"G";
                if (arrKetqua.count > 0) {
                    cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber1.text = @"...";
                }
                if (arrKetqua1.count > 0) {
                    cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                    }
                else {
                    cell.labelNumber2.text = @"...";
                }
            }
            else if (indexPath.row == 9) {
                cell.labelTitle.text = @"DB";
                
                cell.labelTitle.textColor = [UIColor redColor];
                cell.labelNumber1.textColor = [UIColor redColor];
                cell.labelNumber2.textColor = [UIColor redColor];
                
                if (arrKetqua.count > 0) {
                    cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber1.text = @"...";
                }
                if (arrKetqua1.count > 0) {
                        cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber2.text = @"...";
                }
            }
            else {
                cell.labelTitle.text = [NSString stringWithFormat:@"%d",9 - indexPath.row];
                
                if (arrKetqua.count > 0) {
                   
                    cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber1.text = @"...";
                }
                if (arrKetqua1.count > 0) {
                    cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber2.text = @"...";
                }
            }
            
            return cell;
        }
        else if (self.numberProvince == 3) {
            TableBacThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableBacThreeCell class]) forIndexPath:indexPath];
            
            cell.contraint_W_Label.constant = 20;
            
            cell.labelTitle.backgroundColor = backGroudColor;
            cell.labelNumber1.backgroundColor = backGroudColor;
            cell.labelNumber2.backgroundColor = backGroudColor;
            cell.labelNumber3.backgroundColor = backGroudColor;
            
            cell.labelTitle.textColor = [UIColor blackColor];
            cell.labelNumber1.textColor = [UIColor blackColor];
            cell.labelNumber2.textColor = [UIColor blackColor];
            cell.labelNumber3.textColor = [UIColor blackColor];
            
            if (indexPath.row == 0) {
                cell.labelTitle.text = @"G";
                if (arrKetqua.count > 0) {
                    cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber1.text = @"...";
                }
                
                if (arrKetqua1.count > 0) {
                    cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber2.text = @"...";
                }
                
                if (arrKetqua2.count > 0) {
                    cell.labelNumber3.text = [[[arrKetqua2 valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber3.text = @"...";
                }
                
            }
            else if (indexPath.row == 9) {
                cell.labelTitle.text = @"DB";
                
                cell.labelTitle.textColor = [UIColor redColor];
                cell.labelNumber1.textColor = [UIColor redColor];
                cell.labelNumber2.textColor = [UIColor redColor];
                cell.labelNumber3.textColor = [UIColor redColor];
                
                if (arrKetqua.count > 0) {
                    cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber1.text = @"...";
                }
                if (arrKetqua1.count > 0) {
                    cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber2.text = @"...";
                }
                
                if (arrKetqua2.count > 0) {
                    cell.labelNumber3.text = [[[arrKetqua2 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber3.text = @"...";
                }
            }
            else {
                cell.labelTitle.text = [NSString stringWithFormat:@"%d",9 - indexPath.row];
                if (arrKetqua.count > 0) {
                    cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber1.text = @"...";
                }
                if (arrKetqua1.count > 0) {
                    cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber2.text = @"...";
                }
                
                if (arrKetqua2.count > 0) {
                    cell.labelNumber3.text = [[[arrKetqua2 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber3.text = @"...";
                }
            }
             return cell;
        }
        else if (self.numberProvince == 4) {
            TableBacFourCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableBacFourCell class]) forIndexPath:indexPath];
            
            cell.contraint_W_Label.constant = 20;
            
            cell.labelTitle.backgroundColor = backGroudColor;
            cell.labelNUmber1.backgroundColor = backGroudColor;
            cell.labelNumber2.backgroundColor = backGroudColor;
            cell.labelNumber3.backgroundColor = backGroudColor;
            cell.labelNumber4.backgroundColor = backGroudColor;
            
            cell.labelTitle.textColor = [UIColor blackColor];
            cell.labelNUmber1.textColor = [UIColor blackColor];
            cell.labelNumber2.textColor = [UIColor blackColor];
            cell.labelNumber3.textColor = [UIColor blackColor];
            cell.labelNumber4.textColor = [UIColor blackColor];
            
            if (indexPath.row == 0) {
                cell.labelTitle.text = @"G";
                
                if (arrKetqua.count > 0) {
                    cell.labelNUmber1.text = [[[arrKetqua valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNUmber1.text = @"...";
                }
                
                if (arrKetqua1.count > 0) {
                    cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber2.text = @"...";
                }
                
                if (arrKetqua2.count > 0) {
                    cell.labelNumber3.text = [[[arrKetqua2 valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber3.text = @"...";
                }
                
                if (arrKetqua3.count > 0) {
                    cell.labelNumber4.text = [[[arrKetqua3 valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber4.text = @"...";
                }
                
            }
            else if (indexPath.row == 9) {
                cell.labelTitle.text = @"DB";
                
                cell.labelTitle.textColor = [UIColor redColor];
                cell.labelNUmber1.textColor = [UIColor redColor];
                cell.labelNumber2.textColor = [UIColor redColor];
                cell.labelNumber3.textColor = [UIColor redColor];
                cell.labelNumber4.textColor = [UIColor redColor];
                
                if (arrKetqua.count > 0) {
                    cell.labelNUmber1.text = [[[arrKetqua valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNUmber1.text = @"...";
                }
                if (arrKetqua1.count > 0) {
                    cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber2.text = @"...";
                }
                
                if (arrKetqua2.count > 0) {
                    cell.labelNumber3.text = [[[arrKetqua2 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber3.text = @"...";
                }
                
                if (arrKetqua3.count > 0) {
                    cell.labelNumber4.text = [[[arrKetqua3 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber4.text = @"...";
                }
            }
            else {
                cell.labelTitle.text = [NSString stringWithFormat:@"%d",9 - indexPath.row];
                if (arrKetqua.count > 0) {
                    cell.labelNUmber1.text = [[[arrKetqua valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNUmber1.text = @"...";
                }
                if (arrKetqua1.count > 0) {
                    cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber2.text = @"...";
                }
                
                if (arrKetqua2.count > 0) {
                    cell.labelNumber3.text = [[[arrKetqua2 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber3.text = @"...";
                }
                
                if (arrKetqua3.count > 0) {
                    cell.labelNumber4.text = [[[arrKetqua3 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
                }
                else {
                    cell.labelNumber4.text = @"...";
                }
            }
             return cell;
            
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (IBAction)ChonMien:(UISegmentedControl *)sender {
    self.typeTableCell = sender.selectedSegmentIndex + 1;
}

-(void)setTypeTableCell:(TableType)typeTableCell {
    _typeTableCell = typeTableCell;
    
    self.segmentChonMien.selectedSegmentIndex = typeTableCell -1;
    if (self.typeTableCell == TableTypeMienBac) {
        if (([[NSDate date] hour] < 18 || ([[NSDate date] hour] == 18 && [[NSDate date] minute] < 15))) {
            self.labelThongbao.text = @"Chưa có kết quả, mời bạn quay lại sau 18h15'";
            self.indical.hidden = YES;
            self.labelThongbao.hidden = NO;
            self.contraint_H_ViewThongbao.constant = 30;
        
        }
        else if ([[NSDate date] hour] == 18 && [[NSDate date] minute] >= 15 && [[NSDate date] minute] <= 30) {
            self.labelThongbao.text = @"Đang tường thuật xổ số miền Bắc";
            self.indical.hidden = NO;
            self.labelThongbao.hidden = NO;
            self.contraint_H_ViewThongbao.constant = 30;
        }
        else {
            self.labelThongbao.hidden = YES;
            self.indical.hidden = YES;
            self.contraint_H_ViewThongbao.constant = 0;
            
            if (!self.showPopUpPhangBac) {
                [UIAlertView showWithTitle:@"Thông báo" message:@"Bạn biết phang con gì ngày mai chưa?" cancelButtonTitle:@"Đã biết" otherButtonTitles:@[@"Chưa biết"] tapBlock:^(UIAlertView *alert, NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        CauVipController *cauvip = [CauVipController new];
                        [self.navigationController pushViewController:cauvip animated:YES];
                    }
                }];
                
                self.showPopUpPhangBac = YES;
            }
        }
    }
    else if (self.typeTableCell == TableTypeMienTrung) {
        if (([[NSDate date] hour] < 17 || ([[NSDate date] hour] == 17 && [[NSDate date] minute] < 15))) {
            
            self.labelThongbao.text = @"Chưa có kết quả, mời bạn quay lại sau 17h15'";
            self.indical.hidden = YES;
            self.labelThongbao.hidden = NO;
            self.contraint_H_ViewThongbao.constant = 30;
            
        }
        else if ([[NSDate date] hour] == 17 && [[NSDate date] minute] >= 15 && [[NSDate date] minute] <= 30) {
            self.labelThongbao.text = @"Đang tường thuật xổ số miền Trung";
            self.indical.hidden = NO;
            [self.indical startAnimating];
            self.labelThongbao.hidden = NO;
            self.contraint_H_ViewThongbao.constant = 30;
        }
        else {
            
            self.labelThongbao.hidden = YES;
            self.indical.hidden = YES;
            self.contraint_H_ViewThongbao.constant = 0;
            if (!self.showPopUpPhangTrung) {
                [UIAlertView showWithTitle:@"Thông báo" message:@"Bạn biết phang con gì ngày mai chưa?" cancelButtonTitle:@"Đã biết" otherButtonTitles:@[@"Chưa biết"] tapBlock:^(UIAlertView *alert, NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        CauVipController *cauvip = [CauVipController new];
                        [self.navigationController pushViewController:cauvip animated:YES];
                    }
                }];
                
                self.showPopUpPhangTrung = YES;
            }
        }
    }
    else if (self.typeTableCell == TableTypeMienNam) {
        if (([[NSDate date] hour] < 16 || ([[NSDate date] hour] == 16 && [[NSDate date] minute] < 15))) {
            
            self.labelThongbao.text = @"Chưa có kết quả, mời bạn quay lại sau 16h15'";
            self.indical.hidden = YES;
            self.labelThongbao.hidden = NO;
            self.contraint_H_ViewThongbao.constant = 30;
            
        }
        else if ([[NSDate date] hour] == 16 && [[NSDate date] minute] >= 15 && [[NSDate date] minute] <= 30) {
            self.labelThongbao.text = @"Đang tường thuật xổ số miền Nam";
            self.indical.hidden = NO;
            [self.indical startAnimating];
            self.labelThongbao.hidden = NO;
            self.contraint_H_ViewThongbao.constant = 30;
        }
        else {
            
            self.labelThongbao.hidden = YES;
            self.indical.hidden = YES;
            self.contraint_H_ViewThongbao.constant = 0;
            if (!self.showPopUpPhangNam) {
                [UIAlertView showWithTitle:@"Thông báo" message:@"Bạn biết phang con gì ngày mai chưa?" cancelButtonTitle:@"Đã biết" otherButtonTitles:@[@"Chưa biết"] tapBlock:^(UIAlertView *alert, NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        CauVipController *cauvip = [CauVipController new];
                        [self.navigationController pushViewController:cauvip animated:YES];
                    }
                }];
                
                self.showPopUpPhangNam = YES;
            }
        }
    }
    
    [self loadDataRealTime];
    
    if (self.typeTableCell == TableTypeMienBac) {
        self.labelTitle.text = @"Xổ Số Miền Bắc";
    }
    else if (self.typeTableCell == TableTypeMienTrung) {
        self.labelTitle.text = @"Xổ Số Miền Trung";
    }
    else if (self.typeTableCell == TableTypeMienNam) {
        self.labelTitle.text = @"Xổ Số Miền Nam";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
