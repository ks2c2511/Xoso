//
//  DangkiController.m
//  XoSo
//
//  Created by Khoa Le on 9/6/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "DangkiController.h"
#import <NSString+GzCategory.h>
#import "ManageUserStore.h"
#import "User.h"
#import <NSManagedObject+GzDatabase.h>
#import "LoginUser.h"


@interface DangkiController () {
    NSString *userId, *userName, *userPhone;
    BOOL gioitinh;
}
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;
@property (weak, nonatomic) IBOutlet UITextField *tfTaiKhoan;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPass;
@property (weak, nonatomic) IBOutlet UITextField *tfRepeatPass;
- (IBAction)Dangki:(id)sender;

@end

@implementation DangkiController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Đăng kí";
    self.navigationItem.leftBarButtonItem = self.homeButtonItem;

    self.viewBackGround.layer.borderColor = [UIColor colorWithRed:70.0 / 255.0 green:35.0 / 255.0 blue:4.0 / 255.0 alpha:1.0].CGColor;
    self.viewBackGround.layer.borderWidth = 6.0;
    self.viewBackGround.layer.cornerRadius = 6.0;

    //    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
    //        if (objects.count != 0 ) {
    //            User *use = [objects firstObject];
    //
    //            userId = use.user_id;
    //            gioitinh = [use.gender boolValue];
    //
    //        }
    //    }];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Dangki:(id)sender {
    if ([self isValid]) {
        [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
        [LoginUser registerUserWithUserName:self.tfTaiKhoan.text Password:self.tfPass.text Phone:@"123456789" Email:self.tfEmail.text Gender:1 User_Phone_Id:[[NSUUID UUID] UUIDString] Done: ^(BOOL success) {
            if (success) {
                [UIAlertView showWithTitle:@"Thông báo" message:@"Đăng kí thành công." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock: ^(UIAlertView *alertView, NSInteger buttonIndex) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:notificationCapnhatuser object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:notification_show_home object:nil];
                }];
            }
            else {
                [UIAlertView showWithTitle:@"Thông báo" message:@"Đăng kí thất bại. Tài khoản đã tồn tại. Xin thử lại" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            }
            [MRProgressOverlayView dismissAllOverlaysForView:self.view animated:YES];
        }];

          }
}

// check valid cho emial va pass
- (BOOL)isValid {
    if (!self.tfEmail.text.isEmail) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Sai định dạng email." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return NO;
    }
    else if (self.tfPass.text.isBlank) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Cần nhập password." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return NO;
    }
    else if (![self.tfPass.text isEqualToString:self.tfRepeatPass.text]) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Mật khẩu bạn nhập không khớp." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return NO;
    }
    return YES;
}

@end
