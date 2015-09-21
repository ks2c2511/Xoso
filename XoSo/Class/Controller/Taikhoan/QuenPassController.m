//
//  QuenPassController.m
//  XoSo
//
//  Created by Khoa Le on 8/16/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "QuenPassController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "ManageUserStore.h"
#import <UIAlertView+Blocks.h>
#import <NSString+GzCategory.h>

@interface QuenPassController ()
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;
@property (weak, nonatomic) IBOutlet UITextField *textfieldEmail;
- (IBAction)LayMatKhau:(id)sender;

@end

@implementation QuenPassController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.navigationItem.title = @"Lấy lại mật khẩu";
    
    
    self.viewBackGround.layer.borderColor = [UIColor colorWithRed:70.0/255.0 green:35.0/255.0 blue:4.0/255.0 alpha:1.0].CGColor;
    self.viewBackGround.layer.borderWidth = 6.0;
    self.viewBackGround.layer.cornerRadius = 6.0;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)LayMatKhau:(id)sender {
    
    if ([self checkValid]) {
        [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
        [ManageUserStore QuenMatkhauWithEmail:self.textfieldEmail.text Done:^(BOOL success) {
            [MRProgressOverlayView dismissAllOverlaysForView:self.view animated:YES];
            
            [UIAlertView showWithTitle:@"Thành công" message:@"Mật khẩu mới được gửi tới email của bạn." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            self.textfieldEmail.text = @"";
        }];
    }
    
}

-(BOOL)checkValid {
    
    if (self.textfieldEmail.text.isBlank) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Bạn cần nhập email để lấy lại mật khẩu" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return NO;
    }
    else if (!self.textfieldEmail.text.isEmail) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Sai định dạng email" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return NO;
    }
    
    return YES;
}
@end
