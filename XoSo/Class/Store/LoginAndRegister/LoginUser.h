//
//  LoginUser.h
//  XoSo
//
//  Created by Khoa Le on 7/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUser : NSObject
+(void)registerUserWithUserName:(NSString *)username Password:(NSString *)pass Phone:(NSString *)phone Email:(NSString *)email Gender:(NSInteger)gender User_Phone_Id:(NSString *)userPhoneId Done:(void(^)(BOOL success))done;

+(void)loginWithUserName:(NSString *)user_name Pass:(NSString *)pass DeviceId:(NSString *)deviceId Done:(void (^)(BOOL success))done;

+ (void)capnhatUserWithUSerName:(NSString *)userName Done:(void (^)(BOOL success))done;

+(void)truTienWithUserName:(NSString *)user_name Pass:(NSString *)pass DeviceId:(NSString *)deviceId Done:(void (^)(BOOL success))done;
@end
