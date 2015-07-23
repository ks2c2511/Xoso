//
//  XemKQXSStore.h
//  XoSo
//
//  Created by Khoa Le on 7/8/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XemKQXSModel.h"

@interface XemKQXSStore : NSObject
+ (void)GetResultByDateWithDate:(NSString *)date CompanyId:(NSNumber *)companyId Done:(void (^)(BOOL success,NSArray *arr))done;
@end
