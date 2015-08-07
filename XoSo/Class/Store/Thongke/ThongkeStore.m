//
//  ThongkeStore.m
//  XoSo
//
//  Created by Khoa Le on 8/7/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeStore.h"
#import <GzNetworking.h>
#import "ConstantDefine.h"

@implementation ThongkeStore
+ (void)thongkeWithLuotQuay:(NSInteger)luotquay MaTinh:(NSInteger)matinh Xem:(NSString *)xem Type:(NSString *)loto Done:(void (^)(BOOL success, NSArray *arr))done {
    NSDictionary *dic = @{ @"luotquay": @(luotquay),
                           @"matinh":@(matinh),
                           @"xem":xem,
                           @"type":loto };

    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_THONGKE_CAPSO] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *arr;

            arr = [MTLJSONAdapter modelsOfClass:[ThongkeCapSoModel class] fromJSONArray:responseObject error:nil];

            done(YES, arr);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO, nil);
        }
    }];
}

+ (void)thongkeDauDuoiWithLuotQuay:(NSInteger)luotquay MaTinh:(NSInteger)matinh Xem:(NSString *)xem Type:(NSString *)loto Done:(void (^)(BOOL success, NSArray *arr))done {
    NSDictionary *dic = @{ @"luotquay": @(luotquay),
                           @"matinh":@(matinh),
                           @"xem":xem,
                           @"type":loto };

    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_THONGKE_DAUDUOI] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *arr;

            arr = [MTLJSONAdapter modelsOfClass:[ThongkeCapSoModel class] fromJSONArray:responseObject error:nil];

            done(YES, arr);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO, nil);
        }
    }];
}

+ (void)thongkeHaiSoCuoiWithLuotQuay:(NSInteger)luotquay MaTinh:(NSInteger)matinh Done:(void (^)(BOOL success, NSArray *arr))done {
    NSDictionary *dic = @{ @"soluotquay": @(luotquay),
                           @"matinh":@(matinh) };

    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_THONGKE_HAISOCUOI] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            done(YES, responseObject);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO, nil);
        }
    }];
}

@end
