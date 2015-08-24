//
//  HopThuStore.h
//  XoSo
//
//  Created by Khoa Le on 8/19/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSManagedObject+GzDatabase.h>
#import "Hopthu.h"

@interface HopThuStore : NSObject
+(void)GetEmailWithType:(NSInteger)type Done:(void(^)(BOOL success,NSArray *arr))done;
@end
