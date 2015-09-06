//
//  XemKQXSStore.h
//  XoSo
//
//  Created by Khoa Le on 7/8/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XemKQXSModel.h"
#import "DauDuoiModel.h"

@interface XemKQXSStore : NSObject
+ (void)GetResultByDateWithDate:(NSString *)date CompanyId:(NSNumber *)companyId Done:(void (^)(BOOL success,NSArray *arrKqsx,NSArray *arrLoto))done;

+(void)GetResultNearTimeWithMaTinh:(NSNumber *)matinh SoLanQuay:(NSInteger)solanquay Done:(void (^)(BOOL success,NSArray *arrKqsx,NSArray *arrLoto))done;

+(void)GetResultPreDayWithResultDate:(NSString *)date MaTinh:(NSString *)matinh Ckorder:(NSInteger)index KhoangCachDenNgay:(NSInteger)kc Done:(void (^)(BOOL success,NSArray *arrKqsx,NSArray *arrLoto))done;
@end
