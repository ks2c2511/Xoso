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
            
                User *user = [User CreateEntityDescription];
                user.user_id = responseObject[@"user_id"];
                user.user_name = responseObject[@"user_name"];
                user.password = responseObject[@"user_password"];
                user.email = responseObject[@"user_email"];
                user.phone = responseObject[@"user_phone"];
                user.gender = @([responseObject[@"user_gender"] integerValue]);
                user.point = @([responseObject[@"point"] integerValue]);
                user.phone_id =userPhoneId;
                [user saveToPersistentStore];
                


            done (YES);
       
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

+(void)truTienWithUserName:(NSString *)user_name Pass:(NSString *)pass DeviceId:(NSString *)deviceId Done:(void (^)(BOOL success))done {
    NSDictionary *dic = @{@"USER_NAME": !user_name?@"":user_name,
                          @"USER_PASSWORD":!pass?@"":pass,
                          @"android_ID":!deviceId?@"":deviceId,
                          @"type_login":@(5)
                          };
    
    [[GzNetworking sharedInstance] POST:[BASE_URL stringByAppendingString:POST_LOGIN] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)responseObject count] == 0) {
                done (YES);
                return;
            }
            
            NSArray *arr = [User fetchAll];
            
            if (arr.count != 0) {
                User *user = arr[0];
                user.user_id = responseObject[0][@"user_id"];
                user.user_name = responseObject[0][@"user_name"];
                user.password = responseObject[0][@"user_password"];
                user.email = responseObject[0][@"user_email"];
                user.phone = responseObject[0][@"user_phone"];
                user.gender = @([responseObject[0][@"user_gender"] integerValue]);
                user.point = @([responseObject[0][@"point"] integerValue]);
                [user saveToPersistentStore];
                
            }
            else {
                User *user = [User CreateEntityDescription];
                user.user_id = responseObject[0][@"user_id"];
                user.user_name = responseObject[0][@"user_name"];
                user.password = responseObject[0][@"user_password"];
                user.email = responseObject[0][@"user_email"];
                user.phone = responseObject[0][@"user_phone"];
                user.gender = @([responseObject[0][@"user_gender"] integerValue]);
                user.point = @([responseObject[0][@"point"] integerValue]);
                [user saveToPersistentStore];
            }
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

+(void)loginWithUserName:(NSString *)user_name Pass:(NSString *)pass DeviceId:(NSString *)deviceId Done:(void (^)(BOOL success))done {
    NSDictionary *dic = @{@"USER_NAME": !user_name?@"":user_name,
                          @"USER_PASSWORD":!pass?@"":pass,
                          @"android_ID":!deviceId?@"":deviceId,
                          };
    
    [[GzNetworking sharedInstance] POST:[BASE_URL stringByAppendingString:POST_LOGIN] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)responseObject count] == 0) {
                done (YES);
                return;
            }
            
            NSArray *arr = [User fetchAll];

            if (arr.count != 0) {
                User *user = arr[0];
                user.user_id = responseObject[0][@"user_id"];
                user.user_name = responseObject[0][@"user_name"];
                user.password = responseObject[0][@"user_password"];
                user.email = responseObject[0][@"user_email"];
                user.phone = responseObject[0][@"user_phone"];
                user.gender = @([responseObject[0][@"user_gender"] integerValue]);
                user.point = @([responseObject[0][@"point"] integerValue]);
                [user saveToPersistentStore];
                
            }
            else {
                User *user = [User CreateEntityDescription];
                user.user_id = responseObject[0][@"user_id"];
                user.user_name = responseObject[0][@"user_name"];
                user.password = responseObject[0][@"user_password"];
                user.email = responseObject[0][@"user_email"];
                user.phone = responseObject[0][@"user_phone"];
                user.gender = @([responseObject[0][@"user_gender"] integerValue]);
                user.point = @([responseObject[0][@"point"] integerValue]);
                [user saveToPersistentStore];
            }
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

+ (void)capnhatUserWithUSerName:(NSString *)userName Done:(void (^)(BOOL success))done {
    NSDictionary *dic = @{@"user_id": !userName?@"":userName,
                            };
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:POST_CAPNHAT] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)responseObject count] == 0) {
                done (YES);
                return;
            }
            
            NSArray *arr = [User fetchAll];
            
            if (arr.count != 0) {
                User *user = arr[0];
                user.user_id = responseObject[0][@"user_id"];
                user.user_name = responseObject[0][@"user_name"];
                user.password = responseObject[0][@"user_password"];
                user.email = responseObject[0][@"user_email"];
                user.phone = responseObject[0][@"user_phone"];
                user.gender = @([responseObject[0][@"user_gender"] integerValue]);
                user.point = @([responseObject[0][@"point"] integerValue]);
                [user saveToPersistentStore];
                
            }
            else {
                User *user = [User CreateEntityDescription];
                user.user_id = responseObject[0][@"user_id"];
                user.user_name = responseObject[0][@"user_name"];
                user.password = responseObject[0][@"user_password"];
                user.email = responseObject[0][@"user_email"];
                user.phone = responseObject[0][@"user_phone"];
                user.gender = @([responseObject[0][@"user_gender"] integerValue]);
                user.point = @([responseObject[0][@"point"] integerValue]);
                [user saveToPersistentStore];
            }
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
    
//    [[GzNetworking sharedInstance] POST:[BASE_URL stringByAppendingString:POST_CAPNHAT] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
//            if ([(NSArray *)responseObject count] == 0) {
//                done (YES);
//                return;
//            }
//            
//            NSArray *arr = [User fetchAll];
//            
//            if (arr.count != 0) {
//                User *user = arr[0];
//                user.user_id = responseObject[0][@"user_id"];
//                user.user_name = responseObject[0][@"user_name"];
//                user.password = responseObject[0][@"user_password"];
//                user.email = responseObject[0][@"user_email"];
//                user.phone = responseObject[0][@"user_phone"];
//                user.gender = @([responseObject[0][@"user_gender"] integerValue]);
//                user.point = @([responseObject[0][@"point"] integerValue]);
//                [user saveToPersistentStore];
//                
//            }
//            else {
//                User *user = [User CreateEntityDescription];
//                user.user_id = responseObject[0][@"user_id"];
//                user.user_name = responseObject[0][@"user_name"];
//                user.password = responseObject[0][@"user_password"];
//                user.email = responseObject[0][@"user_email"];
//                user.phone = responseObject[0][@"user_phone"];
//                user.gender = @([responseObject[0][@"user_gender"] integerValue]);
//                user.point = @([responseObject[0][@"point"] integerValue]);
//                [user saveToPersistentStore];
//            }
//            done(YES);
//        }
//        else {
//            done(NO);
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (error) {
//            done(NO);
//        }
//    }];

}
@end
