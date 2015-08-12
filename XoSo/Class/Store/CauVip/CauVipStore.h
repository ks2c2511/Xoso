//
//  SoiCauStore.h
//  XoSo
//
//  Created by Khoa Le on 8/12/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Province.h"
#import <NSManagedObject+GzDatabase.h>

@interface CauVipStore : NSObject
+(void)GetTinhCoQuaySo:(void(^)(BOOL success,NSArray *arrMienTrung,NSArray *arrMienNam))done;

+(void)soiCauVipWithMaTinh:(NSInteger)matinh Done:(void(^)(BOOL success,NSString *content))done;
@end
