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


//Request

#define BASE_URL @"http://210.211.97.45/sentienich/lottery/"
#define GET_XEM_KQXS_PRE_DAY @"KQXSPREDAY1.php"
#define GET_XEM_KQXS_NGAY_GAN_NHAT @"KQXS10Day.php"
#define GET_XEM_KQXS_THEO_TINH_HIEN_TAI @"KQXS1DayTheoMT.php"
#define GET_THONG_BAO_TREN_HEADER @"thongbao.php"
#define GET_QUANGCAO @"link_google.php"
#define GET_CAP_NHAT @"http://aviostore.com/?tool=apk&name=xo_so_IOS"
#define POST_REGISTER @"register_default_user.php"

//notification

#define notification_show_left_menu @"notification_show_left_menu"


//userDefault

#define user_default_loaded_local_database @"user_default_loaded_local_database"
#endif
