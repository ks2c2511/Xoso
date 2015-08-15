//
//  ChatStore.h
//  XoSo
//
//  Created by Khoa Le on 8/15/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatLeverOneModel.h"
#import "ChatLevelTwoModel.h"
@interface ChatStore : NSObject
+ (void)getChatLevelOneWithPage:(NSInteger)page Done:(void (^)(BOOL success,NSArray *arr))done;

+(void)postCommentWithComment:(NSString *)comment Done:(void(^)(BOOL success,NSArray *arr))done;

+ (void)getChatLevelTwoWithPage:(NSInteger)page ObjectId:(NSString *)obj Done:(void (^)(BOOL, NSArray *))done;

+ (void)postLikeWithObjectID:(NSString *)obj Done:(void (^)(BOOL success))done;
+(void)postSubCommentWithComment:(NSString *)comment ObjectId:(NSString *)obj Done:(void(^)(BOOL success,NSArray *arr))done;
@end
