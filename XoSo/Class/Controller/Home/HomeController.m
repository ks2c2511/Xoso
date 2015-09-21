//
//  HomeController.m
//  XoSo
//
//  Created by Khoa Le on 7/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HomeController.h"
#import "HomeCollectionCell.h"
#import "UIColor+AppTheme.h"
#import "XemKQXSController.h"
#import "LotoOnlineController.h"
#import "Notifi.h"
#import "Ads.h"
#import "User.h"
#import <NSManagedObject+GzDatabase.h>
#import <UIImageView+WebCache.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "KiemxuController.h"
#import "LichSuCuocController.h"
#import "TuongThuatController.h"
#import "ThongKeController.h"
#import "SoiCauController.h"
#import "CauVipController.h"
#import "GiaiMongController.h"
#import "QuayThuController.h"
#import "ChatLevelOneController.h"


static NSString *identifi_HomeCollectionCell = @"identifi_HomeCollectionCell";
@interface HomeController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *arrData;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong, nonatomic) Notifi *notifi;
@property (strong, nonatomic) User *user;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:identifi_HomeCollectionCell];

    [Notifi fetchAllWithBlock: ^(BOOL succeeded, NSArray *objects) {
        if (succeeded) {
            Notifi *noti = [objects firstObject];
            self.labelNavigationTitleRun.text = noti.thongbao;
            _notifi = noti;
        }
    }];

    [User fetchAllWithBlock: ^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0) {
            _user = [objects firstObject];
        }
        else {
            _user = nil;
        }
    }];

    self.bannerView.adUnitID = google_id_Ad;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];


    [[NSNotificationCenter defaultCenter] addObserverForName:pushNotifiReceiveRemotePush object:nil queue:nil usingBlock: ^(NSNotification *note) {
        NSDictionary *userInfo = note.userInfo;

        for (NSString *key in[userInfo allKeys]) {
            if ([key isEqualToString:@"message"]) {
                if ([userInfo[key] isEqualToString:key_push_push_kqxs]) {
                    TuongThuatController *tuongthuat = [TuongThuatController new];
                    [self.navigationController pushViewController:tuongthuat animated:YES];
                }
                else if ([userInfo[key] isEqualToString:key_push_pushcongtien]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadLoginAPI object:nil];
                }
                else if ([userInfo[key] isEqualToString:key_push_pushkhuyenmai]) {
                    KiemxuController *kiemxu = [KiemxuController new];
                    [self.navigationController pushViewController:kiemxu animated:YES];
                }
                else if ([userInfo[key] isEqualToString:key_push_pushsoilo]) {
                    if ([self.user.point integerValue] < [self.notifi.reducemonney integerValue]) {
                        [UIAlertView showWithTitle:@"Thông báo" message:@"Số tiền trong tài khoản không đủ. Bạn có muốn kiếm xu ngay." cancelButtonTitle:@"Huỷ" otherButtonTitles:@[@"Đồng ý"] tapBlock: ^(UIAlertView *alert, NSInteger buttonIndex) {
                            if (buttonIndex == 1) {
                                KiemxuController *kiemXu = [KiemxuController new];
                                [self.navigationController pushViewController:kiemXu animated:YES];
                            }
                        }];
                        return;
                    }
                    else {
                        [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadAndTruTien object:nil];
                        CauVipController *soicau = [CauVipController new];
                        [self.navigationController pushViewController:soicau animated:YES];
                    }
                }
                else if ([userInfo[key] isEqualToString:key_push_pushthongbao]) {
                }
            }
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = self.menuButtonItem;
    self.navigationItem.titleView = self.labelNavigationTitleRun;
}

#pragma mark - collectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (CGSize)  collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width / 3 - 4, 78);
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifi_HomeCollectionCell forIndexPath:indexPath];
    cell.labelTitle.text = self.arrData[indexPath.row][@"title"];

    if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"cau_vip"] || [self.arrData[indexPath.row][@"key"] isEqualToString:@"kiem_xu"]) {
        [cell.imageLogo setImage:[UIImage animatedImageNamed:self.arrData[indexPath.row][@"iconname"] duration:1.0]];
        cell.imageLogo.animationRepeatCount = 0;
        [cell.imageLogo startAnimating];
    }
    else if ([@"game_dam_boc" isEqualToString:self.arrData[indexPath.row][@"key"]]) {
        [Ads fetchAllWithBlock: ^(BOOL succeeded, NSArray *objects) {
            if (objects.count != 0) {
                Ads *ad = [objects firstObject];
                [cell.imageLogo sd_setImageWithURL:[NSURL URLWithString:ad.image]];
                cell.labelTitle.text = ad.title;
            }
        }];
    }

    else {
        [cell.imageLogo setImage:[UIImage imageNamed:self.arrData[indexPath.row][@"iconname"]]];
    }


    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
#if DEBUG
    NSLog(@"---log---> %@", self.arrData[indexPath.row][@"key"]);
#endif
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    HomeCollectionCell *cell = (HomeCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor appOrange];

    [UIView animateWithDuration:.35 animations: ^{
        cell.contentView.backgroundColor = [UIColor clearColor];
    }];

    if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"xem_kqxs"]) {
        XemKQXSController *kqxs = [XemKQXSController new];
        [self.navigationController pushViewController:kqxs animated:YES];
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"game_dam_boc"]) {
        [Ads fetchAllWithBlock: ^(BOOL succeeded, NSArray *objects) {
            if (objects.count != 0) {
                Ads *ad = [objects firstObject];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ad.link]];
            }
        }];
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"loto_online"]) {
        if ([self checkUser]) {
            LotoOnlineController *lotoOnline = [LotoOnlineController new];
            [self.navigationController pushViewController:lotoOnline animated:YES];
        }
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"kiem_xu"]) {
        if ([self checkUser]) {
            KiemxuController *kiemXu = [KiemxuController new];
            [self.navigationController pushViewController:kiemXu animated:YES];
        }
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"lich_su_choi"]) {
        if ([self checkUser]) {
            LichSuCuocController *history = [LichSuCuocController new];
            [self.navigationController pushViewController:history animated:YES];
        }
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"tuong_thuat"]) {
        TuongThuatController *tuongthuat = [TuongThuatController new];
        [self.navigationController pushViewController:tuongthuat animated:YES];
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"thong_ke"]) {
        if ([self checkUser]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadLoginAPI object:nil];
            ThongKeController *thongke = [ThongKeController new];
            [self.navigationController pushViewController:thongke animated:YES];
        }
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"soi_cau"]) {
        if ([self checkUser]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadLoginAPI object:nil];
            if ([self checkTienTrongtaikhoan]) {
                SoiCauController *soicau = [SoiCauController new];
                [self.navigationController pushViewController:soicau animated:YES];
            }
        }
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"cau_vip"]) {
        if ([self checkUser]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:notifiReloadLoginAPI object:nil];
            if ([self checkTienTrongtaikhoan]) {
                CauVipController *soicau = [CauVipController new];
                [self.navigationController pushViewController:soicau animated:YES];
            }

        }
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"giai_mong"]) {
        GiaiMongController *giaimong = [GiaiMongController new];
        [self.navigationController pushViewController:giaimong animated:YES];
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"quay_thu"]) {
        QuayThuController *quaythu = [QuayThuController new];
        [self.navigationController pushViewController:quaythu animated:YES];
    }
    else if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"phong_chat"]) {
        if ([self checkUser]) {
            ChatLevelOneController *chat = [ChatLevelOneController new];
            [self.navigationController pushViewController:chat animated:YES];
        }
    }
}

- (BOOL)checkUser {
    if (self.user == nil) {
        [UIAlertView showWithTitle:@"Thông báo" message:@"Bác chưa đăng nhập. Hãy đăng nhập để sử dụng dịch vụ." cancelButtonTitle:@"Huỷ" otherButtonTitles:@[@"Đăng nhập", @"Đăng kí"] tapBlock: ^(UIAlertView *alert, NSInteger buttonIxdex) {
            if (buttonIxdex == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowLoginOtherUser object:nil];
            }
            else if (buttonIxdex == 2) {
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationShowDangki object:nil];
            }
        }];
        return NO;
    }
    else {
        return YES;
    }
}

- (BOOL)checkTienTrongtaikhoan {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:key_turn_on_nap_the]) {
        return NO;
    }
    if ([self.user.point integerValue] < [self.notifi.reducemonney integerValue]) {
        [UIAlertView showWithTitle:@"Thông báo" message:@"Số tiền trong tài khoản không đủ. Bạn có muốn kiếm xu ngay." cancelButtonTitle:@"Huỷ" otherButtonTitles:@[@"Đồng ý"] tapBlock: ^(UIAlertView *alert, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                KiemxuController *kiemXu = [KiemxuController new];
                [self.navigationController pushViewController:kiemXu animated:YES];
            }
        }];
        return NO;
    }
    else {
        return YES;
    }
}

- (NSArray *)arrData {
    if (!_arrData) {
        _arrData = [[NSArray alloc]
                    initWithContentsOfFile:[[NSBundle mainBundle]
                                            pathForResource:@"HomeData"
                                            ofType:@"plist"]];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:key_turn_on_nap_the]) {
            NSMutableArray *muArr = [NSMutableArray arrayWithArray:_arrData];
            [muArr addObject:[self dicWithIconName:@"kiem_xu_" Key:@"kiem_xu" Title:@"Kiếm xu"]];
            _arrData = muArr;
            muArr = nil;
        }
    }
    return _arrData;
}

- (NSDictionary *)dicWithIconName:(NSString *)iconName Key:(NSString *)key Title:(NSString *)title {
    return @{ @"iconname": iconName, @"key":key, @"title":title };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
