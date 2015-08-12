//
//  SoiCauStore.h
//  XoSo
//
//  Created by Khoa Le on 8/12/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoiCauModel.h"
@interface SoiCauStore : NSObject
+(void)soiCauWithMaTinh:(NSInteger)matinh Done:(void (^)(BOOL success, SoiCauModel *model))done;
@end
