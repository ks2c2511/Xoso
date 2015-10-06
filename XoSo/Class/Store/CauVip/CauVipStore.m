//
//  SoiCauStore.m
//  XoSo
//
//  Created by Khoa Le on 8/12/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "CauVipStore.h"

#import <GzNetworking.h>
#import "ConstantDefine.h"
#import "User.h"


@implementation CauVipStore
+(void)GetTinhCoQuaySo:(void(^)(BOOL success,NSArray *arrMienTrung,NSArray *arrMienNam))done {
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_TINH_QUAY_SO] parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            
           [Province fetchEntityObjectsWithPredicate:[NSPredicate predicateWithFormat:@"province_id IN %@",[responseObject valueForKeyPath:@"COMPANY_ID"]] success:^(BOOL succeeded, NSArray *objects) {
               NSArray *arrMienTrung = [objects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"province_group == 2"]];
               NSArray *arrMienNam = [objects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"province_group == 3"]];
               
               done(YES ,arrMienTrung,arrMienNam);
               
               
           }];
//            if (arr.count != 0) {
//                done(YES, [arr firstObject]);
//            }
//            else {
//                done(NO,nil);
//            }
        }
        else {
            done(NO,nil,nil);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO, nil,nil);
        }
    }];
}

+(void)soiCauVipWithMaTinh:(NSInteger)matinh Done:(void(^)(BOOL success,NSString *content))done {
    
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
            NSDictionary *dic;
            NSString *prefix;
            dic = @{@"matinh": @(matinh),
                    @"type":@(1),
                    @"userid":use.user_id
                    };
            prefix = GET_LOTODACBIET;
            
            
            [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:prefix] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
                    
                    NSArray *arr = responseObject;
                    if (arr.count != 0) {
                        done(YES,[arr[0] objectForKey:@"content"]);
                    }
                    else {
                        done (NO,nil);
                    }
//                    NSArray *arr = [MTLJSONAdapter modelsOfClass:[ThongkeTrungcaoModel class] fromJSONArray:responseObject error:nil];
                }
                else {
                    done (NO,nil);
                }
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                if (error) {
                    done(NO, nil);
                }
            }];
        }
    }];

  
}
@end
