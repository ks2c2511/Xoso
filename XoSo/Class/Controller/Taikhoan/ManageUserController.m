//
//  ManageUserController.m
//  XoSo
//
//  Created by Khoa Le on 8/16/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ManageUserController.h"
#import "User.h"
#import <NSManagedObject+GzDatabase.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <UIAlertView+Blocks.h>
#import "LoginOtherUserController.h"

@interface ManageUserController ()
@property (weak, nonatomic) IBOutlet UILabel *labelTaiKhoan;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;
@property (weak, nonatomic) IBOutlet UILabel *labelDienThoai;
@property (weak, nonatomic) IBOutlet UILabel *labelGioiTinh;
@property (weak, nonatomic) IBOutlet UILabel *labelSodu;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;
- (IBAction)Dangnhapuserkhac:(id)sender;
- (IBAction)Thaydoithongtin:(id)sender;
- (IBAction)Thaydoimatkhau:(id)sender;

@end

@implementation ManageUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"Tài khoản";
    
    self.bannerView.adUnitID = google_id_Ad;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    self.navigationItem.leftBarButtonItem = self.menuButtonItem;
    
    self.viewBackGround.layer.borderColor = [UIColor colorWithRed:70.0/255.0 green:35.0/255.0 blue:4.0/255.0 alpha:1.0].CGColor;
    self.viewBackGround.layer.borderWidth = 6.0;
    self.viewBackGround.layer.cornerRadius = 6.0;

    
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
           
            self.labelTaiKhoan.text = use.user_name;
            self.labelDienThoai.text = use.phone;
            self.labelEmail.text = use.email;
            NSString *sex = [use.gender integerValue] == 0?@"Nam":@"Nữ";
            self.labelGioiTinh.text = sex;
            self.labelSodu.text = [use.point stringValue];
            
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

- (IBAction)Dangnhapuserkhac:(id)sender {
    
    [UIAlertView showWithTitle:@"Thông báo" message:@"Bạn muốn đăng xuất ứng dụng." cancelButtonTitle:@"Có" otherButtonTitles:@[@"Không"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == [alertView cancelButtonIndex]) {
            
            LoginOtherUserController *loginOther = [LoginOtherUserController new];
            [self.navigationController pushViewController:loginOther animated:YES];
            
        } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Không"]) {
            
            
        }
    }];
}

- (IBAction)Thaydoithongtin:(id)sender {
    
}

- (IBAction)Thaydoimatkhau:(id)sender {
}
@end
