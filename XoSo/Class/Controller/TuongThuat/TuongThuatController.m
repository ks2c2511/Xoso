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

typedef NS_ENUM(NSInteger, TableType) {
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
@property (strong,nonatomic) NSArray *arrData;
@property (assign,nonatomic) TableType typeTableCell;
@end

@implementation TuongThuatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [self getTuongThuatWithMien:TableTypeMienBac];
    // Do any additional setup after loading the view from its nib.
}

-(void)getTuongThuatWithMien:(TableType)type {
    
    _typeTableCell = type;
    [TuongthuatStore getTuongThuatTrucTiepWithMaMien:type Done:^(BOOL success, NSArray *arr) {
        
        if (success) {
            _arrData = arr;
            [self.tableView reloadData];
        }
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TuongthuatConvertModel *modelConvert = self.arrData[indexPath.row];
    NSArray *arrKetqua1 = modelConvert.arr1;
    NSArray *arrKetqua2 = modelConvert.arr2;
    
    if (arrKetqua1.count == 0 && arrKetqua2.count == 0) {
        if (indexPath.row == 3 || indexPath.row == 5) {
            return 60;
        }
        return 30;
    }
    else {
        return 30*arrKetqua1.count;
        if (indexPath.row == 3) {
            return 90;
        }
        else if (indexPath.row == 5) {
            return 210;
        }
        else if (indexPath.row == 6) {
            return 60;
        }
        return 30;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuongthuatConvertModel *modelConvert = self.arrData[indexPath.row];
    NSArray *arrKetqua = modelConvert.arr;
    NSArray *arrKetqua1 = modelConvert.arr1;
    NSArray *arrKetqua2 = modelConvert.arr2;
    
    if (arrKetqua1.count == 0 && arrKetqua2.count == 0) {
       
        UIColor *backGroudColor;
        if (indexPath.row %2 == 0) {
            backGroudColor = [UIColor colorWithRed:250.0/255.0 green:255.0/255.0 blue:200.0/255.0 alpha:1.0];
        }
        else backGroudColor = [UIColor whiteColor];
        
        if (indexPath.row == 0 || indexPath.row == 1) {
            TableBacOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableBacOneCell class]) forIndexPath:indexPath];
            if (indexPath.row == 0) {
                cell.labelTitle.text = @"Đặc biệt";
                cell.labelTitle.textColor = [UIColor redColor];
                
                
            }
            else {
                cell.labelTitle.text = @"Giải nhất";
                cell.labelTitle.textColor = [UIColor blackColor];
            }
            
            if (arrKetqua.count != 0) {
                cell.labelNUmber.text = [[arrKetqua firstObject] ket_qua];
            }
            cell.labelTitle.backgroundColor = backGroudColor;
            cell.labelNUmber.backgroundColor = backGroudColor;
            
            return cell;
            
        }
        else if (indexPath.row == 2 ) {
            TableBacTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableBacTwoCell class]) forIndexPath:indexPath];
            cell.labelTitle.backgroundColor = backGroudColor;
            cell.labelNumber1.backgroundColor = backGroudColor;
            cell.labelNumber2.backgroundColor = backGroudColor;
            cell.labelTitle.text = @"Giải Nhì";
            
            if (arrKetqua.count == 2) {
                cell.labelNumber1.text = [[arrKetqua firstObject] ket_qua];
                cell.labelNumber2.text = [[arrKetqua lastObject] ket_qua];
            }
            
            return cell;
            
        }
        else if (indexPath.row == 3 || indexPath.row == 5) {
            TableSixCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableSixCell class]) forIndexPath:indexPath];
            cell.labelTitle.backgroundColor = backGroudColor;
            
            for (int i = 1; i <= 6; i++) {
                [(UILabel *)[cell.contentView viewWithTag:i] setBackgroundColor:backGroudColor];
                if (arrKetqua.count == 6) {
                    [(UILabel *)[cell.contentView viewWithTag:i] setText:[arrKetqua[i-1] ket_qua]];
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
            
            for (int i = 1; i < 5; i++) {
                [(UILabel *)[cell.contentView viewWithTag:i] setBackgroundColor:backGroudColor];
                if (arrKetqua.count == 4) {
                    [(UILabel *)[cell.contentView viewWithTag:i] setText:[arrKetqua[i-1] ket_qua]];
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
            
            for (int i = 1; i < 4; i++) {
                [(UILabel *)[cell.contentView viewWithTag:i] setBackgroundColor:backGroudColor];
                if (arrKetqua.count == 3) {
                    [(UILabel *)[cell.contentView viewWithTag:i] setText:[arrKetqua[i-1] ket_qua]];
                }
            }
            cell.labelTitle.text = @"Giải Sáu";
            
            
            return cell;
        }

    }
    else if (arrKetqua.count != 0 && arrKetqua1.count != 0 && arrKetqua2.count == 0) {
        UIColor *backGroudColor;
        if (indexPath.row %2 != 0) {
            backGroudColor = [UIColor colorWithRed:250.0/255.0 green:255.0/255.0 blue:200.0/255.0 alpha:1.0];
        }
        else backGroudColor = [UIColor whiteColor];
        
        
        TableMIenTrungCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableMIenTrungCell class]) forIndexPath:indexPath];
        
        cell.labelTitle.backgroundColor = backGroudColor;
        
        for (int i = 1; i < 3; i++) {
            [(UILabel *)[cell.contentView viewWithTag:i] setBackgroundColor:backGroudColor];
        }
        
        if (indexPath.row == 0) {
            cell.labelTitle.text = modelConvert.ma_giai;
            
            if (arrKetqua.count > 0) {
                cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
            if (arrKetqua1.count > 0) {
                cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
           
            
        }
        else {
            if ([modelConvert.ma_giai integerValue] == 0 || [modelConvert.ma_giai integerValue] == 9) {
                cell.labelTitle.text = @"DB";
            }
            else {
                cell.labelTitle.text = modelConvert.ma_giai;
            }
            
            
            if (arrKetqua.count > 0) {
                cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
            if (arrKetqua1.count > 0) {
                cell.labelNumber2.text = [[[arrKetqua1 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
        }
    
    
        
        return cell;
    }
    else if (arrKetqua.count != 0 && arrKetqua1.count != 0 && arrKetqua2.count != 0){
        UIColor *backGroudColor;
        if (indexPath.row %2 != 0) {
            backGroudColor = [UIColor colorWithRed:250.0/255.0 green:255.0/255.0 blue:200.0/255.0 alpha:1.0];
        }
        else backGroudColor = [UIColor whiteColor];
        
        TableMienNamCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableMienNamCell class]) forIndexPath:indexPath];
        
        cell.labelTitle.backgroundColor = backGroudColor;
        
        for (int i = 1; i < 4; i++) {
            [(UILabel *)[cell.contentView viewWithTag:i] setBackgroundColor:backGroudColor];
        }
        
        if (indexPath.row == 0) {
            cell.labelTitle.text = modelConvert.ma_giai;
            
            if (arrKetqua.count > 0) {
                cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
            if (arrKetqua1.count > 0) {
                cell.labelNUmber2.text = [[[arrKetqua1 valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
            if (arrKetqua2.count > 0) {
                cell.labelNumber3.text = [[[arrKetqua2 valueForKeyPath:@"province_name"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
        }
        else {
            if ([modelConvert.ma_giai integerValue] == 0 || [modelConvert.ma_giai integerValue] == 9) {
                cell.labelTitle.text = @"DB";
            }
            else {
                cell.labelTitle.text = modelConvert.ma_giai;
            }
            
            if (arrKetqua.count > 0) {
                cell.labelNumber1.text = [[[arrKetqua valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
            if (arrKetqua1.count > 0) {
                cell.labelNUmber2.text = [[[arrKetqua1 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
            if (arrKetqua2.count > 0) {
                cell.labelNumber3.text = [[[arrKetqua2 valueForKeyPath:@"ket_qua"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
            }
        }
                
        return cell;
    }
       return nil;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (IBAction)ChonMien:(UISegmentedControl *)sender {
    self.typeTableCell = sender.selectedSegmentIndex +1;
     [self getTuongThuatWithMien:self.typeTableCell];
    
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
