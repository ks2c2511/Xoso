//
//  SplashController.m
//  XoSo
//
//  Created by Khoa Le on 7/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "SplashController.h"
#import "ThongBao.h"
#import "User.h"
#import "LoginUser.h"
#import <NSManagedObject+GzDatabase.h>
#import <UIAlertView+Blocks.h>

#import "GcmPushStore.h"
#import "ConstantDefine.h"
@interface SplashController ()

@end

@implementation SplashController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:registrationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
        if ([note.userInfo objectForKey:@"registrationToken"]) {
            [GcmPushStore sendPushRegisterKeyWithKey:[note.userInfo objectForKey:@"registrationToken"] Done:^(BOOL success) {
                if (success) {
                    [UIAlertView showWithTitle:@"Success" message:[note.userInfo objectForKey:@"registrationToken"] cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                }
                else {
                    [UIAlertView showWithTitle:@"Error" message:@"Send Server fail" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                }
            }];
        }
        else {
            [UIAlertView showWithTitle:@"Error" message:@"Register push fail" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        }
       
    }];
    
    [ThongBao GetThongBaoWithType:1 Done:^(BOOL success, NSString *thongbao, NSInteger typeShow, NSInteger reduceMonney) {
        
    }];
    
    [ThongBao GetAdsWithDone:^(BOOL success) {
        
    }];
    
    [ThongBao GetUpdateAppWithDone:^(BOOL update, NSString *link) {
        if (update) {
            [UIAlertView showWithTitle:@"Thông báo" message:@"Ứng dụng Sổ Xố huyền thoại đã có phiên bản mới. Bạn có muốn cập nhật?" cancelButtonTitle:@"OK" otherButtonTitles:@[@"Cancel"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == [alertView cancelButtonIndex]) {
                    
                    NSLog(@"Cancelled");
                } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
                    NSLog(@"Have a cold beer");
                }
            }];
        }
    }];
    
    [User fetchAllWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count == 0) {
        [LoginUser registerUserWithUserName:[[NSUUID UUID] UUIDString] Password:[[NSUUID UUID] UUIDString] Phone:@"123456789" Email:@"nhap_email_cua_ban@email.com" Gender:1 User_Phone_Id:[[NSUUID UUID] UUIDString] Done:^(BOOL success) {
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationCapnhatuser object:nil];
            
        }];
        }
        else {
            User *user = [objects firstObject];
             [LoginUser loginWithUserName:user.user_name Pass:user.password DeviceId:user.phone_id Done:^(BOOL success) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:notificationCapnhatuser object:nil];
                 
             }];
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
