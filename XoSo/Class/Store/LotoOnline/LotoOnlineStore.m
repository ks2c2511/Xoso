//
//  LotoOnlineStore.m
//  XoSo
//
//  Created by Khoa Le on 7/27/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LotoOnlineStore.h"
#import "ConstantDefine.h"
#import <GzNetworking.h>
#import "Province.h"
#import <NSManagedObject+GzDatabase.h>
#import "User.h"

@implementation LotoOnlineStore
+(void)getLotoTypeWithDate:(NSString *)date Done:(void (^)(BOOL success, NSArray *arr))done {
    
    NSDictionary *dic = @{@"date": date};
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_LOTO_TYPE] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[LotoTypeModel class] fromJSONArray:responseObject error:nil];
        
            NSMutableArray *arrType1 = [NSMutableArray array];
            NSMutableArray *arrType2 = [NSMutableArray array];
            NSMutableArray *arrType3 = [NSMutableArray array];
            
            NSMutableArray *arrProvince1 = [NSMutableArray array];
            NSMutableArray *arrProvince2 = [NSMutableArray array];
            NSMutableArray *arrProvince3 = [NSMutableArray array];
           
        
            for (LotoTypeModel *model in arr) {
                 NSPredicate *pre = [NSPredicate predicateWithFormat:@"province_id == %@",model.COMPANY_ID];
             NSArray *results = [Province fetchEntityObjectsWithPredicate:pre];
                if (results.count != 0) {
                    Province *pro = [results firstObject];
                    if ([pro.province_group integerValue] == 1) {
                        [arrType1 addObject:model];
                        [arrProvince1 addObject:pro];
                    }
                    else if ([pro.province_group integerValue] == 2){
                        [arrType2 addObject:model];
                        [arrProvince2 addObject:pro];
                    }
                    else if ([pro.province_group integerValue] == 3) {
                        [arrType3 addObject:model];
                        [arrProvince3 addObject:pro];
                    }
                }
            }
            
            LotoRegionModel *model1 = [LotoRegionModel new];
            model1.arrLotoType = arrType1;
            model1.arrProvince = [[NSSet setWithArray: arrProvince1] allObjects];
            model1.regionId = @"1";
            model1.regionName = @"Miền Bắc";
            
            LotoRegionModel *model2 = [LotoRegionModel new];
            model2.arrLotoType = arrType2;
            model2.arrProvince = [[NSSet setWithArray: arrProvince2] allObjects];
            model2.regionId = @"2";
            model2.regionName = @"Miền Trung";
            
            LotoRegionModel *model3 = [LotoRegionModel new];
            model3.arrLotoType = arrType2;
            model3.arrProvince = [[NSSet setWithArray: arrProvince3] allObjects];
            model3.regionId = @"2";
            model3.regionName = @"Miền Nam";
            
            done(YES,@[model1,model2,model3]);
            
            
            
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

+(void)postLotoWithDate:(NSString *)date LotoTypeId:(NSString *)lototypeId LotoNumber:(NSString *)lotoNumber PointDatCuoc:(NSInteger)point Done:(void (^)(BOOL success,NSArray *data))done {
    
    NSArray *arr = [User fetchAll];
    
    NSString *user = @"";
    if (arr.count != 0) {
        user = [arr[0] user_id];
    }
    
    NSDictionary *dic = @{@"user_id": user,
                          @"date":date,
                          @"lotto_type_id":lototypeId,
                          @"lotto_number":lotoNumber,
                          @"point_number":@(point)};
    
    
    [[GzNetworking sharedInstance] POST:[BASE_URL stringByAppendingString:POST_SEND_NUMBER_LOTO_ONLINE] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            done(YES,responseObject);
        }
        else {
            done(NO,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO,Nil);
        }
    }];
}
@end
