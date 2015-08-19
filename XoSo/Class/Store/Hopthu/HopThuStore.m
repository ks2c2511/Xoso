//
//  HopThuStore.m
//  XoSo
//
//  Created by Khoa Le on 8/19/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HopThuStore.h"
#import <GzNetworking.h>
#import "ConstantDefine.h"
#import "User.h"
#import <NSManagedObject+GzDatabase.h>

@implementation HopThuStore
+(void)GetEmailWithType:(NSInteger)type Done:(void(^)(BOOL success,NSArray *arr))done {
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
            NSDictionary *dic;
            dic = @{@"type":@(type),
                    @"user_id":use.user_id};
            
            
            [[GzNetworking sharedInstance] GET:[BASE_URL_TEST stringByAppendingString:GET_EMAIL_LIST] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
                    
                    NSArray *arr = [MTLJSONAdapter modelsOfClass:[HopThuModel class] fromJSONArray:responseObject error:nil];
                    done(YES,arr);
                    
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
