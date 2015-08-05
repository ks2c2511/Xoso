//
//  HistoryStore.h
//  XoSo
//
//  Created by Khoa Le on 7/29/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryModel.h"

@interface HistoryStore : NSObject

+(void)getHistoryWithPage:(NSInteger )page Done:(void (^)(BOOL success,NSArray *data))done;
@end
