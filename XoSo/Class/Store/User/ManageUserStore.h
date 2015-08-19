//
//  ManageUserStore.h
//  XoSo
//
//  Created by Khoa Le on 8/16/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageUserStore : NSObject

+ (void)LoginOtherUserWithUserName:(NSString *)username Pass:(NSString *)pass Done:(void(^)(BOOL success,NSString *str))done;

+ (void)QuenMatkhauWithEmail:(NSString *)email Done:(void(^)(BOOL success))done;

+(void)changeInfoWithUserId:(NSString *)userId Name:(NSString *)name Email:(NSString *)email Phone:(NSString *)phone GioiTinh:(NSInteger)gioitinh Done:(void(^)(BOOL success,NSString *str))done;

+(void)changeInfoWithUserId:(NSString *)userId Pass:(NSString *)pass Done:(void(^)(BOOL success))done;
@end
