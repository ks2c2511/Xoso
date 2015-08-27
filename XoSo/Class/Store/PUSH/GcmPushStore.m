//
//  GcmPushStore.m
//  XoSo
//
//  Created by Khoa Le on 8/27/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "GcmPushStore.h"
#import <GzNetworking.h>

@implementation GcmPushStore
+(void)sendPushRegisterKeyWithKey:(NSString *)key Done:(void(^)(BOOL success))done {
    
    NSDictionary *dic = @{@"regId":key,
                          @"imei":[[[UIDevice currentDevice] identifierForVendor] UUIDString]};
    [[GzNetworking sharedInstance] GET:@"http://quangcaotrendidong.com:8082/ava-cloud-system/gcm_server_php/register.php" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        done (YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        done (NO);
    }];
    
}
@end
