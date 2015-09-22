//
//  NaptheStore.m
//  XoSo
//
//  Created by Khoa Le on 8/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "NaptheStore.h"
#import "ConstantDefine.h"
#import <GzNetworking.h>

@implementation NaptheStore
+(void)getNoiDungWithDone:(void(^)(BOOL success,NSString *noidung,NSString *dauso,NSString *cuphap))done {
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_NOI_DUNG_NAP_THE] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)responseObject count] == 0) {
                done (NO,nil,nil,nil);
                return;
            }
            NSDictionary *dic = responseObject[0];
            if (dic) {
                 done (YES,dic[@"noidung"],dic[@"dauso"],dic[@"cuphap"]);
            }
            else {
                 done (YES,nil,nil,nil);
            }
            
        }
        else {
            done(NO,nil,nil,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO,nil,nil,nil);
        }
    }];
}

+(void)getNapTheWithsUserId:(NSString *)userId Carttype:(NSString *)cartType CartData:(NSString *)cardData Serial:(NSString *)serial Done:(void(^)(BOOL success,NSString *str))done {
    NSDictionary *dic = @{@"u_id":userId,
                          @"cardtype":cartType,
                          @"cardData":cardData,
                          @"serial":serial,
                          @"​app_id":@"1"};
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_NAP_QUA_THE] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)responseObject count] == 0) {
                done (NO,nil);
                return;
            }
            NSDictionary *dic = responseObject[0];
            
            for (NSString *key in dic.allKeys) {
                if ([key isEqualToString:@"error_service"]) {
                    done(NO,dic[key]);
                    return;
                }
            }
            if (dic) {
                done (YES,nil);
            }
            else {
                done (NO,nil);
            }
            
        }
        else {
            done(NO,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO,nil);
        }
    }];
}
@end
