//
//  ManageUserStore.m
//  XoSo
//
//  Created by Khoa Le on 8/16/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ManageUserStore.h"
#import "ConstantDefine.h"
#import "User.h"
#import <NSManagedObject+GzDatabase.h>
#import <GzNetworking.h>

@implementation ManageUserStore
+ (void)LoginOtherUserWithUserName:(NSString *)username Pass:(NSString *)pass Done:(void(^)(BOOL success))done {
    NSDictionary *dic = @{@"USER_NAME": username,
                          @"USER_PASSWORD":pass};
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_LOGIN_OTHER_USER] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSString class]]) {
            
                      done(YES);
        }
        else {
            done(NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO);
        }
    }];
}

+ (void)QuenMatkhauWithEmail:(NSString *)email Done:(void(^)(BOOL success))done {
    NSDictionary *dic = @{@"email": email
                          };
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_FORGOT_PASS] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSString class]]) {
            
            done(YES);
        }
        else {
            done(NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO);
        }
    }];
}
@end
