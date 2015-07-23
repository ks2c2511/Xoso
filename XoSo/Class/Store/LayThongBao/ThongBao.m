//
//  ThongBao.m
//  XoSo
//
//  Created by Khoa Le on 7/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongBao.h"
#import "ConstantDefine.h"
#import <GzNetworking.h>
#import <NSManagedObject+GzDatabase.h>
#import "Notifi.h"
#import "Ads.h"

@interface ThongBao ()

@end

@implementation ThongBao


+(void)GetThongBaoWithType:(NSInteger)type Done:(void(^)(BOOL success,NSString *thongbao,NSInteger typeShow,NSInteger reduceMonney))done {
    
    
    NSDictionary *dic = @{@"type": @(type)};
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_THONG_BAO_TREN_HEADER] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            
            if ([(NSArray *)responseObject count] == 0) {
                return;
            }
            
            NSArray *arrtb = [Notifi fetchAll];
            if (arrtb.count == 0) {
                Notifi *notifi = [Notifi CreateEntityDescription];
                notifi.thongbao = responseObject[0][@"content"];
                notifi.type = @([responseObject[0][@"type_show"] integerValue]);
                notifi.reducemonney = @([responseObject[0][@"so_tien_tru"] integerValue]);
                [notifi saveToPersistentStore];
                
            }
            else {
                Notifi *noti = [arrtb objectAtIndex:0];
                noti.thongbao = responseObject[0][@"content"];
                noti.type = @([responseObject[0][@"type_show"] integerValue]);
                noti.reducemonney = @([responseObject[0][@"so_tien_tru"] integerValue]);
                [noti saveToPersistentStore];
                
            }
            
            done(YES,@"",0,0);
        }
        else {
           done(NO,Nil,-1,-1);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO,Nil,-1,-1);
        }
    }];
}

+(void)GetAdsWithDone:(void (^)(BOOL success))done {
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_QUANGCAO] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)responseObject count] == 0) {
                return;
            }
            
            NSArray *arr = [Ads fetchAll];
            if (arr.count != 0) {
                Ads *ads = [arr firstObject];
                ads.id_ad = responseObject[0][@"id"];
                ads.title = responseObject[0][@"title"];
                ads.link = responseObject[0][@"link"];
                ads.image = responseObject[0][@"image"];
                [ads saveToPersistentStore];
            }
            else {
                Ads *ads = [Ads CreateEntityDescription];
                ads.id_ad = responseObject[0][@"id"];
                ads.title = responseObject[0][@"title"];
                ads.link = responseObject[0][@"link"];
                ads.image = responseObject[0][@"image"];
                [ads saveToPersistentStore];
            }
            
            
            done (YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO);
        }
    }];
}

+(void)GetUpdateAppWithDone:(void(^)(BOOL update,NSString *link))done {
    [[GzNetworking sharedInstance] GET:GET_CAP_NHAT parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"version_code"] integerValue] > [[NSUserDefaults standardUserDefaults] integerForKey:@"ver_code"]) {
                done(YES,responseObject[@"content"]);
            }
            else{
                done (NO,nil);
            }
            
            [[NSUserDefaults standardUserDefaults] setInteger:[responseObject[@"version_code"] integerValue] forKey:@"ver_code"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        done(NO,nil);
    }];
}
@end
