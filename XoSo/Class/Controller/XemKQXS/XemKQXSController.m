//
//  XemKQXSController.m
//  XoSo
//
//  Created by Khoa Le on 7/5/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "XemKQXSController.h"

@interface XemKQXSController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonChonngay;
@property (weak, nonatomic) IBOutlet UILabel *labelNameCity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XemKQXSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectCity:(id)sender {
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
