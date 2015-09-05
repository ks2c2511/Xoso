//
//  DoiMatKhauController.m
//  XoSo
//
//  Created by Khoa Le on 8/17/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "DoiMatKhauController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "User.h"
#import <NSManagedObject+GzDatabase.h>
#import <NSString+GzCategory.h>
#import <UIAlertView+Blocks.h>
#import "ManageUserStore.h"

@interface DoiMatKhauController () {
    NSString *userId;
}
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITextField *tfPass;
@property (weak, nonatomic) IBOutlet UITextField *tfRepeatPass;
- (IBAction)DongY:(id)sender;

@end

@implementation DoiMatKhauController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
          
            userId = use.user_id;
            
        }
    }];
    
    self.bannerView.adUnitID = google_id_Ad;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    self.navigationItem.title = @"Đổi thông tin";
    
    
    self.viewBackGround.layer.borderColor = [UIColor colorWithRed:70.0/255.0 green:35.0/255.0 blue:4.0/255.0 alpha:1.0].CGColor;
    self.viewBackGround.layer.borderWidth = 6.0;
    self.viewBackGround.layer.cornerRadius = 6.0;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)checkValid {
    if (self.tfPass.text.isBlank || self.tfRepeatPass.text.isBlank) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Vui lòng nhập đẩy đủ thông tin." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return NO;
    }
    else if (![self.tfRepeatPass.text isEqualToString:self.tfPass.text]) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Nhập lại mật khẩu không khớp." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return NO;
    }
    return YES;
}
- (IBAction)DongY:(id)sender {
    
    if ([self checkValid]) {
        [ManageUserStore changeInfoWithUserId:userId Pass:self.tfPass.text Done:^(BOOL success) {
            
            if (success) {
                [UIAlertView showWithTitle:@"Thành công" message:@"Cập nhật thông tin thành công" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadLoginAPI object:nil];
            }
            else {
                [UIAlertView showWithTitle:@"Lỗi" message:@"Có lỗi xảy ra trong quá trình cập nhật. Vui lòng thử lại." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            }

        }];
    }
}
@end
