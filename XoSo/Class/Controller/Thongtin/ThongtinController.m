//
//  ThongtinController.m
//  XoSo
//
//  Created by Khoa Le on 8/18/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongtinController.h"

@interface ThongtinController ()
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;
- (IBAction)OpenFacebook:(id)sender;

@end

@implementation ThongtinController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Thông tin";
    
   
    
    self.navigationItem.leftBarButtonItem = self.homeButtonItem;
    
    self.viewBackGround.layer.borderColor = [UIColor colorWithRed:70.0/255.0 green:35.0/255.0 blue:4.0/255.0 alpha:1.0].CGColor;
    self.viewBackGround.layer.borderWidth = 6.0;
    self.viewBackGround.layer.cornerRadius = 6.0;
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

- (IBAction)OpenFacebook:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://m.facebook.com/pages/Xo-so-huyen-thoai/1388501588081117"]];
}
@end
