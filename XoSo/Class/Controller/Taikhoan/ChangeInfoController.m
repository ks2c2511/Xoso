//
//  ChangeInfoController.m
//  XoSo
//
//  Created by Khoa Le on 8/17/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChangeInfoController.h"
#import "User.h"
#import <NSManagedObject+GzDatabase.h>
#import <NSString+GzCategory.h>
#import <UIAlertView+Blocks.h>
#import "ManageUserStore.h"
@interface ChangeInfoController () {
    NSString *userId,*userName;
    
    BOOL isNam;
}
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UIButton *buttonNam;
@property (weak, nonatomic) IBOutlet UIButton *buttonNu;
- (IBAction)DongY:(id)sender;
- (IBAction)ChonGioiTinh:(UIButton *)sender;

@end

@implementation ChangeInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.navigationItem.title = @"Đổi thông tin";
    
    
    self.viewBackGround.layer.borderColor = [UIColor colorWithRed:70.0/255.0 green:35.0/255.0 blue:4.0/255.0 alpha:1.0].CGColor;
    self.viewBackGround.layer.borderWidth = 6.0;
    self.viewBackGround.layer.cornerRadius = 6.0;
    
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
            self.tfName.text = use.user_name;
            userName = use.user_name;
            self.tfEmail.text = use.email;
            self.tfPhone.text = use.phone;
            userId = use.user_id;
            
            isNam = ![use.gender boolValue];
            
            if (isNam) {
                [self.buttonNam setImage:[UIImage imageNamed:@"ic_check_box.png"] forState:UIControlStateNormal];
                
            }
            else {
                [self.buttonNu setImage:[UIImage imageNamed:@"ic_check_box.png"] forState:UIControlStateNormal];
            }
        }
    }];

    // Do any additional setup after loading the view from its nib.
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

-(BOOL)checkValid {
    
    if (self.tfPhone.text.isBlank || self.tfName.text.isBlank|| self.tfEmail.text.isBlank) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Vui lòng điền đầy đủ thông tin." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
    }
    if (!self.tfEmail.text.isEmail) {
        [UIAlertView showWithTitle:@"Lỗi" message:@"Sai định dạng email." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        return NO;
    }
    
    return YES;
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

- (IBAction)DongY:(id)sender {
    
    if ([self checkValid]) {
        [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
        [ManageUserStore changeInfoWithUserId:userId Name:self.tfName.text OldName:userName Email:self.tfEmail.text Phone:self.tfPhone.text GioiTinh:!isNam Done:^(BOOL success,NSString *str) {
            [MRProgressOverlayView dismissAllOverlaysForView:self.view animated:YES];
            
            if (success) {
                [UIAlertView showWithTitle:@"Thành công" message:@"Cập nhật thông tin thành công" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
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

- (IBAction)ChonGioiTinh:(UIButton *)sender {
    
    if ([sender isEqual:self.buttonNam]) {
        isNam = YES;
    }
    else {
        isNam = NO;
    }
  

    [self.buttonNam setImage:[UIImage imageNamed:@"ic_check_box_outline_blank.png"] forState:UIControlStateNormal];
    [self.buttonNu setImage:[UIImage imageNamed:@"ic_check_box_outline_blank.png"] forState:UIControlStateNormal];
    
    if (isNam) {
        [self.buttonNam setImage:[UIImage imageNamed:@"ic_check_box.png"] forState:UIControlStateNormal];
        
    }
    else {
         [self.buttonNu setImage:[UIImage imageNamed:@"ic_check_box.png"] forState:UIControlStateNormal];
    }
}
@end
