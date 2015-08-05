//
//  LotoOnlineStore.h
//  XoSo
//
//  Created by Khoa Le on 7/27/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LotoTypeModel.h"
#import "LotoRegionModel.h"
@interface LotoOnlineStore : NSObject
+(void)getLotoTypeWithDate:(NSString *)date Done:(void (^)(BOOL success,NSArray *arrData))done;

+(void)postLotoWithDate:(NSString *)date LotoTypeId:(NSString *)lototypeId LotoNumber:(NSString *)lotoNumber PointDatCuoc:(NSInteger)point Done:(void (^)(BOOL success,NSArray *data))done;
@end
