//
//  ThongkeStore.h
//  XoSo
//
//  Created by Khoa Le on 8/7/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThongkeCapSoModel.h"
#import "LichSuChoiModel.h"
#import "ThongKeDiemCaoModel.h"

@interface ThongkeStore : NSObject
+(void)thongkeWithLuotQuay:(NSInteger)luotquay MaTinh:(NSInteger)matinh Xem:(NSString *)xem Type:(NSString *)loto Done:(void (^)( BOOL success, NSArray *arr))done;
+(void)thongkeDauDuoiWithLuotQuay:(NSInteger)luotquay MaTinh:(NSInteger)matinh Xem:(NSString *)xem Type:(NSString *)loto Done:(void (^)( BOOL success, NSArray *arr))done;
+(void)thongkeHaiSoCuoiWithLuotQuay:(NSInteger)luotquay MaTinh:(NSInteger)matinh Done:(void (^)( BOOL success, NSArray *arr))done;

+ (void)lichsuchoiWithDone:(void (^)( BOOL success, NSArray *arr))done;

+(void)thongkeUserDiemCaoWithType:(NSInteger)type Done:(void (^)( BOOL success, NSArray *arr, NSString *pointUser,NSString *leverUser))done;
@end
