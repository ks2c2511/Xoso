//
//  SoiCauController.m
//  XoSo
//
//  Created by Khoa Le on 8/11/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "SoiCauController.h"
#import "TableListItem.h"
#import "Province.h"
#import <NSManagedObject+GzDatabase.h>
#import "SoiCauStore.h"
#import "CauVipStore.h"

@interface SoiCauController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonChonMien;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UILabel *labelDau;
@property (weak, nonatomic) IBOutlet UILabel *labelCuoi;
@property (weak, nonatomic) IBOutlet UILabel *labelDacbiet;
@property (weak, nonatomic) IBOutlet UILabel *labelLoto;
@property (weak, nonatomic) IBOutlet UILabel *labelXien;
@property (weak, nonatomic) IBOutlet UIView *viewContainner;
@property (strong, nonatomic) TableListItem *tableListItem;
@property (strong, nonatomic) TableListItem *tableMaMien;
@property (assign, nonatomic) NSInteger matinh,mamien;
@property (strong,nonatomic) NSArray *arrMien;
@property (strong,nonatomic) NSArray *arrMienTrung,*arrMienName;
@property (assign, nonatomic) NSInteger matinhTrung,matinhNam;

- (IBAction)SelectMien:(id)sender;
- (IBAction)SelectCity:(id)sender;
@end

@implementation SoiCauController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Soi Cầu";
    [self customView];
    
    self.matinh = 1;
    self.mamien = 1;
    
    
    [CauVipStore GetTinhCoQuaySo:^(BOOL success, NSArray *arrMienTrung, NSArray *arrMienNam) {
        
        if (success) {
            self.arrMienTrung = arrMienTrung;
            self.arrMienName = arrMienNam;
            
//            if (arrMienTrung.count != 0) {
//                Province *pro = [arrMienTrung firstObject];
//                [self.buttonChonTInhMienTrung setTitle:pro.province_name forState:UIControlStateNormal];
//                self.matinhTrung = [pro.province_id integerValue];
//            }
//            if (arrMienNam.count != 0) {
//                Province *pro = [arrMienNam firstObject];
//                [self.buttonChonTinhMienNam setTitle:pro.province_name forState:UIControlStateNormal];
//                self.matinhNam = [pro.province_id integerValue];
//            }
            
        }
    }];

    [self loadData];
    
    
      // Do any additional setup after loading the view from its nib.
}

-(void)loadData {
    [SoiCauStore soiCauWithMaTinh:self.matinh Done:^(BOOL success, SoiCauModel *model) {
        
        [self setDataWithSoicau:model];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadAndTruTien object:nil];
    }];
}

-(void)setDataWithSoicau:(SoiCauModel *)model {
    if (model == nil) {
        self.labelCuoi.text = @"";
        self.labelDacbiet.text = @"";
        self.labelDau.text = @"";
        self.labelLoto.text = @"";
        self.labelXien.text = @"";
    }
    else {
        self.labelCuoi.text = [NSString stringWithFormat:@"%@",model.TK_DUOI];
        self.labelDacbiet.text = [NSString stringWithFormat:@"%@",model.TK_DB];
        self.labelDau.text = [NSString stringWithFormat:@"%@",model.TK_DAU];
        self.labelLoto.text = [NSString stringWithFormat:@"%@",model.TK_LOTO];
        self.labelXien.text = [NSString stringWithFormat:@"%@",model.TK_XIEN];
    }
   }

-(void)customView {
    self.viewContainner.layer.cornerRadius = 6.0;
    self.viewContainner.layer.borderColor = [UIColor colorWithRed:70.0/255.0 green:35.0/255.0 blue:4.0/255.0 alpha:1.0].CGColor;
    self.viewContainner.layer.borderWidth = 10.0;
}

- (TableListItem *)tableListItem {
    if (!_tableListItem) {
        _tableListItem = [[TableListItem alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableListItem.arrData = [Province fetchEntityObjectsWithPredicate:[NSPredicate predicateWithFormat:@"province_group == %d",self.mamien]];
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
            
            [weakSelf loadData];
            
        }];
        
        [self.view addSubview:_tableListItem];
    }
    
    return _tableListItem;
}

- (TableListItem *)tableMaMien {
    if (!_tableMaMien) {
        _tableMaMien = [[TableListItem alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableMaMien.arrData = self.arrMien;
        [_tableMaMien setTableViewCellConfigBlock: ^(TableListCell *cell, NSDictionary *mien) {
            cell.labelTttle.text = mien[@"ten"];
            
            if (self.mamien == [mien[@"mamien"] integerValue]) {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_checked_white.png"]];
            }
            else {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_unchecked_white.png"]];
            }
        }];
        
        __weak typeof(self) weakSelf = self;
        
        [_tableMaMien setSelectItem: ^(NSIndexPath *indexPath, NSDictionary *item) {
            [weakSelf.buttonChonMien setTitle: item[@"ten"] forState:UIControlStateNormal];
            weakSelf.mamien = [item[@"mamien"] integerValue];
            
            NSArray *arrTinh = [Province fetchEntityObjectsWithPredicate:[NSPredicate predicateWithFormat:@"province_group == %d",weakSelf.mamien]];
            if (weakSelf.mamien == 2) {
                arrTinh = weakSelf.arrMienTrung;
            }
            else if (weakSelf.mamien == 3) {
                arrTinh = weakSelf.arrMienName;
            }
            
            if (arrTinh.count != 0) {
                 weakSelf.tableListItem.arrData = arrTinh;
                
                Province *pro = [arrTinh firstObject];
                [weakSelf.buttonCity setTitle:pro.province_name forState:UIControlStateNormal];
                weakSelf.matinh = [pro.province_id integerValue];
                [weakSelf loadData];
            }
           
            [weakSelf.tableMaMien reloadData];
            
        }];
        
        [self.view addSubview:_tableMaMien];
    }
    
    return _tableMaMien;
}

-(NSArray *)arrMien {
    if (!_arrMien) {
        _arrMien = @[[self dicMienWithMa:@"1" Ten:@"Miền Bắc"],
                     [self dicMienWithMa:@"2" Ten:@"Miền Trung"],
                     [self dicMienWithMa:@"3" Ten:@"Miền Nam"]];
    }
    return _arrMien;
}

-(NSDictionary *)dicMienWithMa:(NSString *)ma Ten:(NSString *)ten {
    return @{@"mamien": ma,@"ten":ten};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SelectMien:(id)sender {
    
    self.tableMaMien.frame = ({
        CGRect frame = self.buttonChonMien.frame;
        frame.origin.y = CGRectGetMaxY(self.buttonChonMien.frame);
        frame.size.width = CGRectGetWidth(self.buttonChonMien.frame);
        frame.size.height = [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.buttonChonMien.frame) - HeightNavigationBar;
        frame;
    });
    [self.tableMaMien showOrHiden];
}

- (IBAction)SelectCity:(id)sender {
    
    self.tableListItem.frame = ({
        CGRect frame = self.buttonCity.frame;
        frame.origin.y = CGRectGetMaxY(self.buttonCity.frame);
        frame.size.width = CGRectGetWidth(self.buttonCity.frame);
        frame.size.height = [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.buttonCity.frame) - HeightNavigationBar;
        frame;
    });
    [self.tableListItem showOrHiden];
}
@end
