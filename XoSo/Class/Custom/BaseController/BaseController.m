//
//  BaseController.m
//  XoSo
//
//  Created by Khoa Le on 7/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(MarqueeLabel *)labelNavigationTitleRun {
    if (!_labelNavigationTitleRun) {
        _labelNavigationTitleRun = [[MarqueeLabel alloc] initWithFrame:CGRectMake(20, 0, [[UIScreen mainScreen] bounds].size.width - 100, HeightNavigationBar) rate:50 andFadeLength:5];
        
        [_labelNavigationTitleRun setText:@"test text nay co chay tren navigation hay ko? neu chay dc thi ok"];
        [_labelNavigationTitleRun setFont:[UIFont systemFontOfSize:14]];
        [_labelNavigationTitleRun setBackgroundColor:[UIColor clearColor]];
        [_labelNavigationTitleRun setTextColor:[UIColor whiteColor]];
        [_labelNavigationTitleRun setMarqueeType:MLContinuous];
    }
    return _labelNavigationTitleRun;
}

- (UIBarButtonItem *)menuButtonItem {
    if (!_menuButtonItem) {
        _menuButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_menu_white.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(ShowLeftMenu)];
    }
    
    return _menuButtonItem;
}

-(void)ShowLeftMenu {
    [[NSNotificationCenter defaultCenter] postNotificationName:notification_show_left_menu object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
