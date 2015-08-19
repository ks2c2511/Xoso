//
//  BaseController.h
//  XoSo
//
//  Created by Khoa Le on 7/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MarqueeLabel.h>
#import "ConstantDefine.h"

@interface BaseController : UIViewController
@property (strong,nonatomic) MarqueeLabel *labelNavigationTitleRun;
@property (strong, nonatomic) UIBarButtonItem *menuButtonItem;
@property (strong,nonatomic) UIBarButtonItem *homeButtonItem;
@property (strong,nonatomic) UIImageView *imageBackGround;
@end
