//
//  LoginUser.m
//  XoSo
//
//  Created by Khoa Le on 7/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LoginUser.h"
#import <GzNetworking.h>
#import "User.h"
#import <NSManagedObject+GzDatabase.h>
#import "ConstantDefine.h"

@implementation LoginUser
+(void)registerUserWithUserName:(NSString *)username Password:(NSString *)pass Phone:(NSString *)phone Email:(NSString *)email Gender:(NSInteger)gender User_Phone_Id:(NSString *)userPhoneId Done:(void(^)(BOOL success))done {
    
    NSDictionary *dic = @{@"USER_NAME": username,
                          @"USER_PASSWORD":pass,
                          @"USER_PHONE":phone,
                          @"USER_EMAIL":email,
                          @"USER_GENDER":@(gender),
                          @"USER_PHONE_ID":userPhoneId};
    
    [[GzNetworking sharedInstance] POST:[BASE_URL stringByAppendingString:POST_REGISTER] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSArray *arr = [User fetchAll];
            
            for (User *user in arr) {
                [user DeleteThis];
            }
            
            if (arr.count == 0) {
                User *user = [User CreateEntityDescription];
                user.user_id = responseObject[@"user_id"];
                user.user_name = responseObject[@"user_name"];
                user.password = responseObject[@"user_password"];
                user.email = responseObject[@"user_email"];
                user.phone = responseObject[@"user_phone"];
                user.gender = @([responseObject[@"user_gender"] integerValue]);
                user.point = @([responseObject[@"point"] integerValue]);
                user.phone_id =responseObject[@"user_name"];
                [user saveToPersistentStore];
                
            }

            
       
        }
        else {
            done(NO);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO);
        }
    }];
    
//    
//    [[GzNetworking sharedInstance] POST:[BASE_URL stringByAppendingString:POST_REGISTER] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id == %@",responseObject[@"user_id"]];
//            
//            [User fetchEntityObjectsWithPredicate:predicate success:^(BOOL succeeded, NSArray *objects) {
//                
//                for (User *user in objects) {
//                    [user DeleteThis];
//                }
//                
//                if (objects.count == 0) {
//                    User *user = [User CreateEntityDescription];
//                    user.user_id = responseObject[@"user_id"];
//                    user.user_name = responseObject[@"user_name"];
//                    user.password = responseObject[@"user_name"];
//                    user.email = responseObject[@"user_name"];
//                    user.phone = responseObject[@"user_name"];
//                    user.gender = responseObject[@"user_name"];
//                    user.point = responseObject[@"user_name"];
//                    user.phone_id =responseObject[@"user_name"];
//                    [user saveToPersistentStore];
//                    
//                }
//            }];
//        }
//        else {
//            done(NO);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (error) {
//            done(NO);
//        }
//    }];
    
}
@end
