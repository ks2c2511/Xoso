//
//  HopThuStore.m
//  XoSo
//
//  Created by Khoa Le on 8/19/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HopThuStore.h"
#import <GzNetworking.h>
#import "ConstantDefine.h"
#import "User.h"

#import "HopThuModel.h"

@implementation HopThuStore
+(void)GetEmailWithType:(NSInteger)type Done:(void(^)(BOOL success,NSArray *arr))done {
    [User fetchAllInBackgroundWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0 ) {
            User *use = [objects firstObject];
            NSDictionary *dic;
            dic = @{@"type":@(type),
                    @"user_id":use.user_id};
            
            [[GzNetworking sharedInstance] GET:[BASE_URL_TEST stringByAppendingString:GET_EMAIL_LIST] parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
                    
                    NSArray *arr = [MTLJSONAdapter modelsOfClass:[HopThuModel class] fromJSONArray:responseObject error:nil];
                    if (arr.count !=0) {
                        for (HopThuModel *model in arr) {
                            [Hopthu fetchEntityObjectsWithPredicate:[NSPredicate predicateWithFormat:@"idHopthu == %@",model.idHopthu] success:^(BOOL succeeded, NSArray *objects) {
                                if (objects.count != 0) {
                                    Hopthu *hopthu = objects[0];
                                    hopthu.idHopthu = model.idHopthu;
                                    hopthu.subject = model.subject;
                                    hopthu.content = model.content;
                                    hopthu.trung_lo = model.trung_lo;
                                    hopthu.date = model.date;
                                }
                                else {
                                    Hopthu *hopthu = [Hopthu CreateEntityDescription];
                                    hopthu.idHopthu = model.idHopthu;
                                    hopthu.subject = model.subject;
                                    hopthu.content = model.content;
                                    hopthu.trung_lo = model.trung_lo;
                                    hopthu.date = model.date;
                                }
                            }];
                            
                            
                        }
                    }
                    
                    NSError *error;
                    [[GzDatabase ShareDatabase] save:&error];
                    
                    done(YES,[Hopthu fetchAll]);
                    
                }
                else {
                    done (NO,[Hopthu fetchAll]);
                }
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                if (error) {
                    done(NO, [Hopthu fetchAll]);
                }
            }];
        }
    }];
}
@end
