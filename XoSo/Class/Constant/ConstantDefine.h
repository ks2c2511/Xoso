//
//  ConstantDefine.h
//  XoSo
//
//  Created by Khoa Le on 7/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#ifndef XoSo_ConstantDefine_h
#define XoSo_ConstantDefine_h

#define HeightNavigationBar 64.0f
#define HeightToolBar 40.0f
#define WidthScreen [UIScreen mainScreen].bounds.size.width
#define HeightScreen [UIScreen mainScreen].bounds.size.height

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define ratioMenuAndMainView 1.5


//notification

#define notification_show_left_menu @"notification_show_left_menu"
#endif
