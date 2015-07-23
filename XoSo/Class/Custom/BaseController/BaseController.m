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
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.imageBackGround];
    [self.view sendSubviewToBack:self.imageBackGround];
    
    NSDictionary *dic = @{@"images": self.imageBackGround};
    self.view.autoresizingMask = UIViewAutoresizingNone;
    self.imageBackGround.autoresizingMask = UIViewAutoresizingNone;
    
    NSArray *contraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[images]|" options:0 metrics:nil views:dic];
    NSArray *contraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[images]|" options:0 metrics:nil views:dic];
    [self.view addConstraints:contraintsH];
    [self.view addConstraints:contraintsV];
    // Do any additional setup after loading the view.
}


-(MarqueeLabel *)labelNavigationTitleRun {
    if (!_labelNavigationTitleRun) {
        _labelNavigationTitleRun = [[MarqueeLabel alloc] initWithFrame:CGRectMake(20, 0, [[UIScreen mainScreen] bounds].size.width - 100, HeightNavigationBar) rate:50 andFadeLength:5];
    
        [_labelNavigationTitleRun setFont:[UIFont systemFontOfSize:14]];
        [_labelNavigationTitleRun setBackgroundColor:[UIColor clearColor]];
        [_labelNavigationTitleRun setTextColor:[UIColor whiteColor]];
        [_labelNavigationTitleRun setMarqueeType:MLContinuous];
        
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 19)]];
        self.navigationItem.rightBarButtonItem = btn;
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

-(UIImageView *)imageBackGround {
    if (!_imageBackGround) {
        _imageBackGround = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
        _imageBackGround.frame = [UIScreen mainScreen].bounds;
    }
    return _imageBackGround;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
