//
//  ThongBao.h
//  XoSo
//
//  Created by Khoa Le on 7/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThongBao : NSObject

+(void)GetThongBaoWithType:(NSInteger)type Done:(void(^)(BOOL success,NSString *thongbao,NSInteger typeShow,NSInteger reduceMonney))done;
+(void)GetAdsWithDone:(void(^)(BOOL success))done;
+(void)GetUpdateAppWithDone:(void(^)(BOOL update,NSString *link))done;
@end
