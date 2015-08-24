//
//  NaptheStore.h
//  XoSo
//
//  Created by Khoa Le on 8/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NaptheStore : NSObject
+(void)getNoiDungWithDone:(void(^)(BOOL success,NSString *noidung,NSString *dauso,NSString *cuphap))done;
+(void)getNapTheWithsUserId:(NSString *)userId Carttype:(NSString *)cartType CartData:(NSString *)cardData Serial:(NSString *)serial Done:(void(^)(BOOL success,NSString *str))done;
@end
