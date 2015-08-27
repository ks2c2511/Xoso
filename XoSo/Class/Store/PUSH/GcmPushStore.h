//
//  GcmPushStore.h
//  XoSo
//
//  Created by Khoa Le on 8/27/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GcmPushStore : NSObject
+(void)sendPushRegisterKeyWithKey:(NSString *)key Done:(void(^)(BOOL success))done;
@end
