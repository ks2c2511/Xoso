//
//  CaidatController.m
//  XoSo
//
//  Created by Khoa Le on 8/17/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "CaidatController.h"
#import "ButtonBorder.h"

@interface CaidatController ()
@property (weak, nonatomic) IBOutlet ButtonBorder *buttonThongbao;
@property (weak, nonatomic) IBOutlet UIButton *buttonMienBac;
@property (weak, nonatomic) IBOutlet UIButton *buttonMIenTrung;
@property (weak, nonatomic) IBOutlet UIButton *buttonMienNam;
@property (weak, nonatomic) IBOutlet ButtonBorder *buttonRungChuong;

- (IBAction)ThongBao:(id)sender;
- (IBAction)RungChuong:(id)sender;

@end

@implementation CaidatController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)ThongBao:(id)sender {
}

- (IBAction)RungChuong:(id)sender {
}
@end
