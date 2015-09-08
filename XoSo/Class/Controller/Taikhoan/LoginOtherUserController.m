//
//  LoginOtherUserController.m
//  XoSo
//
//  Created by Khoa Le on 8/16/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LoginOtherUserController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <NSString+GzCategory.h>
#import <UIAlertView+Blocks.h>
#import "ManageUserStore.h"
#import "QuenPassController.h"


@interface LoginOtherUserController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonLuuMatKhau;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITextField *textfieldNameUser;
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;
@property (weak, nonatomic) IBOutlet UITextField *textfieldPass;

@property (assign,nonatomic) BOOL isSavePass;
- (IBAction)QuenMatKhau:(id)sender;
- (IBAction)NhapMatKhau:(id)sender;
- (IBAction)LuuMatKhau:(id)sender;
- (IBAction)DangNhap:(id)sender;

@end

@implementation LoginOtherUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerView.adUnitID = google_id_Ad;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    self.navigationItem.title = @"Đăng nhập";
    self.navigationItem.leftBarButtonItem = self.homeButtonItem;
    
    
    self.viewBackGround.layer.borderColor = [UIColor colorWithRed:70.0/255.0 green:35.0/255.0 blue:4.0/255.0 alpha:1.0].CGColor;
    self.viewBackGround.layer.borderWidth = 6.0;
    self.viewBackGround.layer.cornerRadius = 6.0;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)QuenMatKhau:(id)sender {
    
    QuenPassController *quenPass = [QuenPassController new];
    [self.navigationController pushViewController:quenPass animated:YES];
    
}

- (IBAction)NhapMatKhau:(id)sender {
    
}

- (IBAction)LuuMatKhau:(id)sender {
    _isSavePass = !self.isSavePass;
    
    if (self.isSavePass) {
        [self.buttonLuuMatKhau setImage:[UIImage imageNamed:@"ic_check_box"] forState:UIControlStateNormal];
    }
    else {
         [self.buttonLuuMatKhau setImage:[UIImage imageNamed:@"ic_check_box_outline_blank.png"] forState:UIControlStateNormal];
    }
}



- (IBAction)DangNhap:(id)sender {
    
    if ([self validSubmit]) {
        [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
        [ManageUserStore LoginOtherUserWithUserName:self.textfieldNameUser.text Pass:self.textfieldPass.text Done:^(BOOL success,NSString *str) {
            [MRProgressOverlayView dismissAllOverlaysForView:self.view animated:YES];
            if (success) {
                [MRProgressOverlayView dismissAllOverlaysForView:self.view animated:YES];
                [UIAlertView showWithTitle:@"Thành công" message:@"Đăng nhập thành công." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:notificationCapnhatuser object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:notification_show_home object:nil];

                }];
            }
            else {
                 [UIAlertView showWithTitle:@"Thất bại" message:@"Đăng nhập thất bại. Vui lòng kiểm tra lại thông tin tài khoản." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            }
        }];
    }
    
}


-(BOOL)validSubmit {
    if (self.textfieldNameUser.text.isBlank || self.textfieldPass.text.isBlank) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Bạn cần nhập đầy đủ tên đăng nhập và mật khẩu." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
    }
    
    return YES;
}
@end
