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

#define BASE_URL_TEST @"http://210.211.97.45/sentienich/lottery/"
#define BASE_URL @"http://sentienich.aviostore.com/lottery/"
#define GET_XEM_KQXS_PRE_DAY @"KQXSPREDAY1.php"
#define GET_XEM_KQXS_NGAY_GAN_NHAT @"KQXS10Day.php"
#define GET_XEM_KQXS_THEO_TINH_HIEN_TAI @"KQXS1DayTheoMT.php"
#define GET_THONG_BAO_TREN_HEADER @"thongbao.php"
#define GET_QUANGCAO @"link_google.php"
#define GET_CAP_NHAT @"http://aviostore.com/?tool=apk&name=xo_so_IOS"
#define POST_REGISTER @"register_default_user.php"
#define POST_LOGIN @"login.php"
#define GET_LOTO_TYPE @"return_locaion_lototype_id.php"
#define GET_REAL_TIME_SERVER @"get_server_current_date.php"
#define POST_SEND_NUMBER_LOTO_ONLINE @"insert_lotonumber_userpoint.php"
#define GET_HISTORY @"process/get_history.php"

#define GET_TUONGTHUAT_TRUCTIEP @"Tructiep.php"

#define GET_THONGKE_CAPSO @"TKCapso.php"
#define GET_THONGKE_DAUDUOI @"TKDauDuoi.php"
#define GET_THONGKE_HAISOCUOI @"TKTong2socuoi.php"
#define GET_LICHSUCHOI @"process/get_list_loto_user.php"
#define GET_THONGKE_DIEMCHOI @"Thong_ke_diem_choi.php"
#define GET_THONGKETRUNGCAONHAT @"process/get_top_user_trung.php"
#define GET_THONGKE_CHUKI @"TKchukyLoto.php"
#define GET_SOICAU @"Soicau.php"
#define GET_TINH_QUAY_SO @"process/return_location_id.php"
#define GET_LOTODACBIET @"soilo.php"
#define GET_LIST_CHAT @"process/get_list_chat.php"
#define GET_ADD_COMMENT_LEVELONE @"process/add_subject_chat.php"
#define GET_LIST_SUBCOMMENT @"process/get_list_comment.php"
#define GET_LIKE_CHAT @"process/update_like_count.php"
#define GET_SUB_COMMENT @"process/add_comment_chat.php"
#define GET_LOGIN_OTHER_USER @"login.php"
#define GET_FORGOT_PASS @"process/get_password_lost.php"
#define GET_CHANGE_INFO @"update_account.php"
#define GET_CHANGE_PASS @"update_password.php"
#define GET_EMAIL_LIST @"danhsach_email.php"
#define GET_NOI_DUNG_NAP_THE @"xoso_thongbao_napthe.php"
#define GET_NAP_QUA_THE @"process/vnepay/card_charging.php"
//notification

#define notification_show_left_menu @"notification_show_left_menu"
#define notification_show_home @"notification_show_home"
#define notificationShowManageUser @"notificationShowManageUser"
#define notificationShowLoginOtherUser @"notificationShowLoginOtherUser"
#define notificationShowInfoUser @"notificationShowInfoUser"
#define notificationShowHuongDanUser @"notificationShowHuongDanUser"
#define notificationShowHopthu @"notificationShowHopthu"
#define notificationCapnhatuser @"notificationCapnhatuser"

//constance

//key push

#define key_push_push_kqxs @"push_kqxs"
#define key_push_pushsoilo @"pushsoilo"
#define key_push_pushkhuyenmai @"pushkhuyenmai"
#define key_push_pushthongbao @"pushthongbao"
#define key_push_pushcongtien @"pushcongtien"

#define push_API_key @"AIzaSyCw0keCM-K2JCEnkbmkZUbJmOczmBgYdNU"

#define registrationKey @"onRegistrationCompleted"
#define on_messageKey @"onMessageReceived"


#define google_id_Ad @"ca-app-pub-8172894227923068/6488921439"

#define thong_ke_cap_so @"thongkecapso"
#define thong_ke_chuave @"chuave"
#define thong_ke_dau @"dau"
#define thong_ke_duoi @"duoi"
#define thong_ke_type_dac_biet @"dacbiet"
#define thong_ke_type_loto @"loto"

//userDefault

#define user_default_loaded_local_database @"user_default_loaded_local_database"
#endif
