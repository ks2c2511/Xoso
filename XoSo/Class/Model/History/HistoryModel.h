//
//  HistoryModel.h
//  XoSo
//
//  Created by Khoa Le on 7/29/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface HistoryModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *LOTTO_ID;
@property (strong,nonatomic) NSString *USER_ID;
@property (strong,nonatomic) NSString *DATE;
@property (strong,nonatomic) NSNumber *LOTTO_TYPE_ID;
@property (strong,nonatomic) NSString *LOTTO_NUMBER;
@property (strong,nonatomic) NSNumber *POINT_NUMBER;
@property (strong,nonatomic) NSNumber *ITERATIONS;
@property (strong,nonatomic) NSNumber *POINT_REVEICED;
@property (strong,nonatomic) NSNumber *STATUS;
@property (strong,nonatomic) NSString *TYPE_NAME;
@property (strong,nonatomic) NSString *COMPANY_NAME;
@end
