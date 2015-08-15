//
//  ChatStore.m
//  XoSo
//
//  Created by Khoa Le on 8/15/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChatStore.h"
#import <GzNetworking.h>
#import "ConstantDefine.h"
#import "User.h"
#import <NSManagedObject+GzDatabase.h>

@implementation ChatStore
+ (void)getChatLevelOneWithPage:(NSInteger)page Done:(void (^)(BOOL success,NSArray *arr))done {
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_LIST_CHAT] parameters:@{@"page": @(page)} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[ChatLeverOneModel class] fromJSONArray:responseObject error:nil];
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

+ (void)postCommentWithComment:(NSString *)comment Done:(void (^)(BOOL success, NSArray *arr))done {
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
            NSDictionary *dic;
            dic = @{@"user_name":use.user_name,
                    @"userid":use.user_id,
                    @"subject_content" : (comment == nil)? @"":comment};
            
            
            [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_ADD_COMMENT_LEVELONE] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
                    
                    
                    NSArray *arr = [MTLJSONAdapter modelsOfClass:[ChatLeverOneModel class] fromJSONArray:responseObject error:nil];
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

+ (void)getChatLevelTwoWithPage:(NSInteger)page ObjectId:(NSString *)obj Done:(void (^)(BOOL, NSArray *))done {
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_LIST_SUBCOMMENT] parameters:@{@"page": @(page),@"subject_id":obj} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[ChatLevelTwoModel class] fromJSONArray:responseObject error:nil];
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

+ (void)postLikeWithObjectID:(NSString *)obj Done:(void (^)(BOOL success))done {
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_LIKE_CHAT] parameters:@{@"subject_id":obj} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        done(YES);
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO);
        }
    }];
}

+(void)postSubCommentWithComment:(NSString *)comment ObjectId:(NSString *)obj Done:(void(^)(BOOL success,NSArray *arr))done {
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
            NSDictionary *dic;
            dic = @{@"user_name":use.user_name,
                    @"userid":use.user_id,
                    @"comment_content" : (comment == nil)? @"":comment,
                    @"subject_id":obj};
            
            [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_SUB_COMMENT] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
                    
                    NSArray *arr = [MTLJSONAdapter modelsOfClass:[ChatLevelTwoModel class] fromJSONArray:responseObject error:nil];
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
