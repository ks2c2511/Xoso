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
+ (void)LoginOtherUserWithUserName:(NSString *)username Pass:(NSString *)pass Done:(void(^)(BOOL success,NSString *str))done {
    NSDictionary *dic = @{@"USER_NAME": username,
                          @"USER_PASSWORD":pass};
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_LOGIN_OTHER_USER] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)responseObject count] == 0) {
                done (YES,nil);
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
            done (YES,nil);
            
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

+(void)changeInfoWithUserId:(NSString *)userId Name:(NSString *)name OldName:(NSString *)oldName Email:(NSString *)email Phone:(NSString *)phone GioiTinh:(NSInteger)gioitinh Done:(void(^)(BOOL success,NSString *str))done {
    
    NSDictionary *dic;
    if (name == nil || [name isEqualToString:oldName]) {
        dic = @{@"user_id": !userId?@"":userId,
                @"user_phone": !phone?@"":phone,
                @"user_email": !email?@"":email,
                @"user_gender":@(gioitinh)
                };
    }
    else {
        dic = @{@"user_id": !userId?@"":userId,
                @"user_name": !name?@"":name,
                @"user_phone": !phone?@"":phone,
                @"user_email": !email?@"":email,
                @"user_gender":@(gioitinh)
                };
    }
   
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_CHANGE_INFO] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)responseObject count] == 0) {
                done (YES,nil);
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
            done (YES,nil);
            
        }
        else {
            done(NO,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO,operation.responseString);
        }
    }];
}

+(void)changeInfoWithUserId:(NSString *)userId Pass:(NSString *)pass Done:(void(^)(BOOL success))done {
    NSDictionary *dic = @{@"user_id": !userId?@"":userId,
                          @"user_password": !pass?@"":pass
                          };
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_CHANGE_PASS] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
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



@end
