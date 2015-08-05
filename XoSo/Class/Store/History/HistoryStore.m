//
//  HistoryStore.m
//  XoSo
//
//  Created by Khoa Le on 7/29/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HistoryStore.h"
#import <NSManagedObject+GzDatabase.h>
#import "User.h"
#import <GzNetworking.h>
#import "ConstantDefine.h"
@implementation HistoryStore
+(void)getHistoryWithPage:(NSInteger )page Done:(void (^)(BOOL success,NSArray *data))done {
    NSArray *arr = [User fetchAll];
    
    NSString *user = @"";
    if (arr.count != 0) {
        user = [arr[0] user_id];
    }
    NSDictionary *dic = @{@"user_id": user,
                          @"page":@(page),
                         };
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_HISTORY] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[HistoryModel class] fromJSONArray:responseObject error:nil];
            
            done(YES,arr);
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
