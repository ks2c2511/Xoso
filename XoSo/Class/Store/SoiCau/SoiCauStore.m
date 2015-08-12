//
//  SoiCauStore.m
//  XoSo
//
//  Created by Khoa Le on 8/12/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "SoiCauStore.h"
#import "ConstantDefine.h"
#import <GzNetworking.h>
#import "User.h"
#import <NSManagedObject+GzDatabase.h>

@implementation SoiCauStore
+(void)soiCauWithMaTinh:(NSInteger)matinh Done:(void (^)(BOOL success, SoiCauModel *model))done {
    
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
            NSDictionary *dic;
            NSString *prefix;
            dic = @{@"matinh": @(matinh),
                    @"userid":use.user_id};
            prefix = GET_SOICAU;
            
            [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:prefix] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
                    
                    NSArray *arr = [MTLJSONAdapter modelsOfClass:[SoiCauModel class] fromJSONArray:responseObject error:nil];
                    if (arr.count != 0) {
                        done(YES, [arr firstObject]);
                    }
                    else {
                        done(NO,nil);
                    }
                }
                else {
                    done(NO,nil);
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
