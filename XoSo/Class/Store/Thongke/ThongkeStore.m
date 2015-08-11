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
#import "User.h"
#import <NSManagedObject+GzDatabase.h>

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

+ (void)lichsuchoiWithDone:(void (^)( BOOL success, NSArray *arr))done {
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_LICHSUCHOI] parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[LichSuChoiModel class] fromJSONArray:responseObject error:nil];
            done(YES, arr);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO, nil);
        }
    }];

}

+(void)thongkeUserDiemCaoWithType:(NSInteger)type Done:(void (^)( BOOL success, NSArray *arr, NSString *pointUser,NSString *leverUser,NSString *nameUser))done {
   

    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
             NSDictionary *dic;
            NSString *prefix;
                dic = @{@"type": @(type),
                        @"userid":use.user_id};
                prefix = GET_THONGKE_DIEMCHOI;
            
            [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:prefix] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                    
                    NSArray *arr = [MTLJSONAdapter modelsOfClass:[ThongKeDiemCaoModel class] fromJSONArray:[responseObject objectForKey:@"top_ten_point"] error:nil];
                    done(YES, arr, responseObject[@"point_user"],responseObject[@"level_user"],use.user_name);
                }
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                if (error) {
                    done(NO, nil,nil,nil,nil);
                }
            }];

        }
    }];

}

+(void)thongkeUserTrungCaoWithFromDate:(NSString *)fromDate ToDate:(NSString *)todate Done:(void (^)( BOOL success, NSArray *arr))done {
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
            NSDictionary *dic;
            NSString *prefix;
            dic = @{@"fromdate": fromDate,
                    @"todate":todate,
                    @"user_id":use.user_id};
            prefix = GET_THONGKETRUNGCAONHAT;
            
            
            [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:prefix] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
                    
                    NSArray *arr = [MTLJSONAdapter modelsOfClass:[ThongkeTrungcaoModel class] fromJSONArray:responseObject error:nil];
                    done(YES, arr);
                }
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                if (error) {
                    done(NO, nil);
                }
            }];
        }
    }];

}

+ (void)thongkeChukiLotoWithCapso:(NSInteger)capso MaTinh:(NSInteger) matinh Page:(NSInteger )page Done:(void (^)( BOOL success, NSArray *arr))done {
    
    NSDictionary *dic = @{ @"capso": @(capso),
                           @"matinh":@(matinh),
                           @"page":@(page)};
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_THONGKE_CHUKI] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[ThongkeChuki class] fromJSONArray:responseObject error:nil];
            done(YES, arr);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO, nil);
        }
    }];

}

@end
