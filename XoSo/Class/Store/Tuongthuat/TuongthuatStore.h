//
//  TuongthuatStore.h
//  XoSo
//
//  Created by Khoa Le on 8/6/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuongthuatModel.h"
#import "TuongthuatConvertModel.h"
#import "Province.h"
@interface TuongthuatStore : NSObject
+ (void)getTuongThuatTrucTiepWithMaMien:(NSInteger)mamien Done:(void (^)(BOOL success,NSArray *arr))done;
@end
