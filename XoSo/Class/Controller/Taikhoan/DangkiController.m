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

@interface DangkiController () {
    NSString *userId,*userName,*userPhone;
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
    
    self.viewBackGround.layer.borderColor = [UIColor colorWithRed:70.0/255.0 green:35.0/255.0 blue:4.0/255.0 alpha:1.0].CGColor;
    self.viewBackGround.layer.borderWidth = 6.0;
    self.viewBackGround.layer.cornerRadius = 6.0;
    
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
            
            userId = use.user_id;
            gioitinh = [use.gender boolValue];
            
        }
    }];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)Dangki:(id)sender {
    if ([self isValid]) {
        
        [ManageUserStore changeInfoWithUserId:userId Name:self.tfTaiKhoan.text Email:self.tfEmail.text Phone:userPhone GioiTinh:gioitinh Done:^(BOOL success,NSString *str) {
            
            if (success) {
                [ManageUserStore changeInfoWithUserId:userId Pass:self.tfPass.text Done:^(BOOL success) {
                    
                    if (success) {
                        [UIAlertView showWithTitle:@"Thành công" message:@"Đăng kí thành công." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadLoginAPI object:nil];
                    }
                    else {
                        [UIAlertView showWithTitle:@"Lỗi" message:@"Có lỗi xảy ra trong quá trình đăng kí. Vui lòng thử lại." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                    }
                }];
                [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadLoginAPI object:nil];
            }
            else {
                if ([str isEqualToString:@"username_is_exits"]) {
                    [UIAlertView showWithTitle:@"Lỗi" message:@"Tài khoản đã tồn tại." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                }
            }
        }];
    }
    
}

// check valid cho emial va pass
-(BOOL)isValid {
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
