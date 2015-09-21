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
- (IBAction)Bac:(UIButton *)sender;
- (IBAction)Trung:(UIButton *)sender;
- (IBAction)Nam:(UIButton *)sender;
@property (assign, nonatomic) BOOL isBacQuay, isTrungQuay, isNamQuay;
@end

@implementation CaidatController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.imageBackGround.hidden = YES;

    self.navigationItem.title = @"Cài đặt";
    self.navigationItem.leftBarButtonItem = self.homeButtonItem;

    self.isBacQuay = [[NSUserDefaults standardUserDefaults] boolForKey:key_push_alert_mien_bac_quay_so];
    self.isTrungQuay = [[NSUserDefaults standardUserDefaults] boolForKey:key_push_alert_mien_trung_quay_so];
    self.isNamQuay = [[NSUserDefaults standardUserDefaults] boolForKey:key_push_alert_mien_nam_quay_so];

    if (self.isBacQuay) {
        [self.buttonMienBac setImage:[[UIImage imageNamed:@"ic_check_box"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    else {
        [self.buttonMienBac setImage:[[UIImage imageNamed:@"ic_check_box_outline_blank"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }

    if (self.isNamQuay) {
        [self.buttonMienNam setImage:[[UIImage imageNamed:@"ic_check_box"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    else {
        [self.buttonMienNam setImage:[[UIImage imageNamed:@"ic_check_box_outline_blank"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }

    if (self.isTrungQuay) {
        [self.buttonMIenTrung setImage:[[UIImage imageNamed:@"ic_check_box"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    else {
        [self.buttonMIenTrung setImage:[[UIImage imageNamed:@"ic_check_box_outline_blank"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Bac:(UIButton *)sender {
    self.isBacQuay = !self.isBacQuay;
    if (self.isBacQuay) {
        [self.buttonMienBac setImage:[[UIImage imageNamed:@"ic_check_box"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    else {
        [self.buttonMienBac setImage:[[UIImage imageNamed:@"ic_check_box_outline_blank"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }

    [[NSUserDefaults standardUserDefaults] setBool:self.isBacQuay forKey:key_push_alert_mien_bac_quay_so];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)Trung:(UIButton *)sender {
    self.isTrungQuay = !self.isTrungQuay;
    if (self.isTrungQuay) {
        [self.buttonMIenTrung setImage:[[UIImage imageNamed:@"ic_check_box"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    else {
        [self.buttonMIenTrung setImage:[[UIImage imageNamed:@"ic_check_box_outline_blank"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }

    [[NSUserDefaults standardUserDefaults] setBool:self.isTrungQuay forKey:key_push_alert_mien_trung_quay_so];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)Nam:(UIButton *)sender {
    self.isNamQuay = !self.isNamQuay;
    if (self.isNamQuay) {
        [self.buttonMienNam setImage:[[UIImage imageNamed:@"ic_check_box"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    else {
        [self.buttonMienNam setImage:[[UIImage imageNamed:@"ic_check_box_outline_blank"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }

    [[NSUserDefaults standardUserDefaults] setBool:self.isNamQuay forKey:key_push_alert_mien_nam_quay_so];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
