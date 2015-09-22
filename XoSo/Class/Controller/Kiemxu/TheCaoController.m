//
//  TheCaoController.m
//  XoSo
//
//  Created by Khoa Le on 8/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "TheCaoController.h"
#import "ButtonBorder.h"
#import <UIAlertView+Blocks.h>
#import "TableListItem.h"
#import "NaptheStore.h"

@interface TheCaoController ()

@property (strong,nonatomic) NSArray *arrLoaiMang;
- (IBAction)Gui:(id)sender;
- (IBAction)Thoat:(id)sender;
@property (weak, nonatomic) IBOutlet ButtonBorder *buttonChonNhaMang;
@property (strong, nonatomic) TableListItem *tableListItem;
@property (assign,nonatomic) NSString *loaimang;
- (IBAction)ChonMang:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tfMathe;
@property (weak, nonatomic) IBOutlet UITextField *tfSoserial;

@end

@implementation TheCaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Nạp xu qua tài khoản";
    self.imageBackGround.hidden = YES;
    self.loaimang = @"vinaphone";
    
}

- (TableListItem *)tableListItem {
    if (!_tableListItem) {
        _tableListItem = [[TableListItem alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableListItem.arrData = self.arrLoaiMang;
        __weak typeof(self)weakSelf = self;
        [_tableListItem setTableViewCellConfigBlock: ^(TableListCell *cell, NSDictionary *dic) {
            cell.labelTttle.text = dic[@"ten_the"];
            if ([weakSelf.loaimang isEqualToString:dic[@"loai_the"]]) {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_checked_white.png"]];
            }
            else {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_unchecked_white.png"]];
            }
        }];
        
        
        [_tableListItem setSelectItem: ^(NSIndexPath *indexPath, NSDictionary *dic) {
            [weakSelf.buttonChonNhaMang setTitle:dic[@"ten_the"] forState:UIControlStateNormal];
            weakSelf.loaimang = dic[@"loai_the"];
            
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

-(BOOL)isValid {
    if ([self.tfMathe.text isEqualToString:@""] || [self.tfSoserial.text isEqualToString:@""]) {
        [UIAlertView showWithTitle:@"Thông báo" message:@"Bạn cần nhập đầy đủ thông tin mã thẻ và số serial" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return NO;
    }
    
    return YES;
}

- (IBAction)Gui:(id)sender {
    
    if ([self isValid]) {
        [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
        [NaptheStore getNapTheWithsUserId:self.userId Carttype:self.loaimang CartData:self.tfMathe.text Serial:self.tfSoserial.text Done:^(BOOL success, NSString *str) {
            [MRProgressOverlayView dismissAllOverlaysForView:self.view animated:YES];
            if (success) {
                [UIAlertView showWithTitle:@"Thông báo" message:@"Nạp thẻ thành công." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadLoginAPI object:nil];
            }
            else {
                if (str) {
                    [UIAlertView showWithTitle:@"Thông báo" message:str cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                }
                else {
                    [UIAlertView showWithTitle:@"Thông báo" message:@"Nạp thẻ thất bại, xin thử lại." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                }
                
            }
        }];
    }
    
}

- (IBAction)Thoat:(id)sender {
}
- (IBAction)ChonMang:(id)sender {
    self.tableListItem.frame = ({
        CGRect frame = self.buttonChonNhaMang.frame;
        frame.origin.y = CGRectGetMaxY(self.buttonChonNhaMang.frame);
        frame.size.width = CGRectGetWidth(self.buttonChonNhaMang.frame);
        frame.size.height = 260;
        frame;
    });
    [self.tableListItem showOrHiden];

}

-(NSArray *)arrLoaiMang {
    if (!_arrLoaiMang) {
        _arrLoaiMang = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LoaiThe" ofType:@"plist"]];
    }
    return _arrLoaiMang;
}
@end
