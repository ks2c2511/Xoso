//
//  ThongkeDacbiet.m
//  XoSo
//
//  Created by Khoa Le on 8/5/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeDacbiet.h"
#import "ThongkeTable.h"
#import "ThongkeStore.h"

@interface ThongkeDacbiet ()
@property (weak, nonatomic) IBOutlet ThongkeTable *tkTable;

@end

@implementation ThongkeDacbiet

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *type;
    if (self.typeIndex == 0) {
        type = thong_ke_type_dac_biet;
    }
    else if (self.typeIndex == 1) {
        type = thong_ke_type_loto;
    }

    [ThongkeStore thongkeWithLuotQuay:self.luotquay MaTinh:self.matinh Xem:thong_ke_cap_so Type:type Done: ^(BOOL success, NSArray *arr) {
        if (success) {
            self.tkTable.arrData = arr;
        }
    }];
    [self.tkTable setTableCellConfigBlock: ^(ThongkeDetailCell *cell, id item) {
        ThongkeCapSoModel *model = (ThongkeCapSoModel *)item;

        if (self.typeIndex == 0) {
            cell.labelNumber.text = model.dacbiet;
            cell.labelPercent.text = [NSString stringWithFormat:@"%@%% (%@ lần)", model.phan_tram, model.so_lan_xh];
            cell.contraint_W_PercentView.constant = [model.phan_tram integerValue] * maxWidthpercentView / 100  + 10;
            cell.labelNumber.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:45.0/255.0 blue:42.0/255.0 alpha:1.0];
            cell.viewShowPercent.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:138.0/255.0 blue:4.0/255.0 alpha:1.0];
        }
        else if (self.typeIndex == 1) {
            cell.labelNumber.backgroundColor = [UIColor colorWithRed:40.0/255.0 green:119.0/255.0 blue:98.0/255.0 alpha:1.0];
            cell.viewShowPercent.backgroundColor = [UIColor colorWithRed:62.0/255.0 green:191.0/255.0 blue:57.0/255.0 alpha:1.0];
            cell.labelNumber.text = model.loto;
            cell.labelPercent.text = [NSString stringWithFormat:@"%@%% (%@ lần)", model.phan_tram, model.so_lan_xh];
            cell.contraint_W_PercentView.constant = [model.phan_tram integerValue] * maxWidthpercentView / 100  + 10;
        }
    }];


    // Do any additional setup after loading the view from its nib.
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

@end
