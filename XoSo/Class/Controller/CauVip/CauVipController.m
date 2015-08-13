//
//  CauVipController.m
//  XoSo
//
//  Created by Khoa Le on 8/12/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "CauVipController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "CauVipStore.h"
#import "TableListItem.h"
#import <UIAlertView+Blocks.h>

@interface CauVipController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonChonTInhMienTrung;
@property (weak, nonatomic) IBOutlet UIButton *buttonChonTinhMienNam;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong, nonatomic) TableListItem *tableListItem;
@property (strong,nonatomic) NSArray *arrMienTrung,*arrMienName;
@property (assign, nonatomic) NSInteger matinhTrung,matinhNam;
- (IBAction)SoiCauMienTrung:(id)sender;
- (IBAction)SoiCauMienNam:(id)sender;
- (IBAction)SoiCauMienBac:(id)sender;

- (IBAction)ChonMienTrung:(id)sender;
- (IBAction)ChonMienNam:(id)sender;
@end

@implementation CauVipController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageBackGround.hidden = YES;
    self.navigationItem.title = @"Cầu vip";
    
    [CauVipStore GetTinhCoQuaySo:^(BOOL success, NSArray *arrMienTrung, NSArray *arrMienNam) {
        
        if (success) {
            self.arrMienTrung = arrMienTrung;
            self.arrMienName = arrMienNam;
            
            if (arrMienTrung.count != 0) {
                Province *pro = [arrMienTrung firstObject];
                [self.buttonChonTInhMienTrung setTitle:pro.province_name forState:UIControlStateNormal];
                self.matinhTrung = [pro.province_id integerValue];
            }
            if (arrMienNam.count != 0) {
                Province *pro = [arrMienNam firstObject];
                [self.buttonChonTinhMienNam setTitle:pro.province_name forState:UIControlStateNormal];
                self.matinhNam = [pro.province_id integerValue];
            }
           
        }
    }];
    // Do any additional setup after loading the view from its nib.
}

- (TableListItem *)tableListItem {
    if (!_tableListItem) {
        _tableListItem = [[TableListItem alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        [_tableListItem setTableViewCellConfigBlock: ^(TableListCell *cell, Province *pro) {
            cell.labelTttle.text = pro.province_name;
            if (self.matinhTrung == [pro.province_id integerValue]) {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_checked_white.png"]];
            }
            else {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_unchecked_white.png"]];
            }
        }];
        
        __weak typeof(self) weakSelf = self;
        
        [_tableListItem setSelectItem: ^(NSIndexPath *indexPath, Province *pro) {
            if ([pro.province_group integerValue] == 2) {
                [weakSelf.buttonChonTInhMienTrung setTitle:pro.province_name forState:UIControlStateNormal];
                weakSelf.matinhTrung = [pro.province_id integerValue];
            }
            else if ([pro.province_group integerValue] == 3) {
                [weakSelf.buttonChonTinhMienNam setTitle:pro.province_name forState:UIControlStateNormal];
                weakSelf.matinhNam = [pro.province_id integerValue];
            }
          
            
            [weakSelf.tableListItem reloadData];
            
       
            
        }];
        
        [self.view addSubview:_tableListItem];
    }
    
    return _tableListItem;
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

- (IBAction)SoiCauMienTrung:(id)sender {
    [CauVipStore soiCauVipWithMaTinh:self.matinhTrung Done:^(BOOL success, NSString *content) {
        
        
        
        [UIAlertView showWithTitle:@"Thông báo" message:content cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == [alertView cancelButtonIndex]) {
                
                NSLog(@"Cancelled");
            } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
                
                NSLog(@"Have a cold beer");
            }
        }];
    }];
}

- (IBAction)SoiCauMienNam:(id)sender {
    [CauVipStore soiCauVipWithMaTinh:self.matinhNam Done:^(BOOL success, NSString *content) {
        [UIAlertView showWithTitle:@"Thông báo" message:content cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == [alertView cancelButtonIndex]) {
                
                NSLog(@"Cancelled");
            } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
                
                NSLog(@"Have a cold beer");
            }
        }];
    }];
}

- (IBAction)SoiCauMienBac:(id)sender {
    [CauVipStore soiCauVipWithMaTinh:1 Done:^(BOOL success, NSString *content) {
        [UIAlertView showWithTitle:@"Thông báo" message:content cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == [alertView cancelButtonIndex]) {
                
                NSLog(@"Cancelled");
            } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
                
                NSLog(@"Have a cold beer");
            }
        }];
    }];
}

- (IBAction)ChonMienTrung:(id)sender {
    self.tableListItem.arrData = self.arrMienTrung;
    self.tableListItem.frame = ({
        CGRect frame = self.buttonChonTInhMienTrung.frame;
        frame.origin.y = CGRectGetMaxY(self.buttonChonTInhMienTrung.frame);
        frame.size.width = CGRectGetWidth(self.buttonChonTInhMienTrung.frame);
        frame.size.height = 200;
        frame;
    });
    [self.tableListItem showOrHiden];
}

- (IBAction)ChonMienNam:(id)sender {
    
    self.tableListItem.arrData = self.arrMienName;
    self.tableListItem.frame = ({
        CGRect frame = self.buttonChonTinhMienNam.frame;
        frame.origin.y = CGRectGetMaxY(self.buttonChonTinhMienNam.frame);
        frame.size.width = CGRectGetWidth(self.buttonChonTinhMienNam.frame);
        frame.size.height = 200;
        frame;
    });
    [self.tableListItem showOrHiden];
}
@end
