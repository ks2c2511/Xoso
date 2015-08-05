//
//  LotoTypeModel.h
//  XoSo
//
//  Created by Khoa Le on 7/27/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface LotoTypeModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSNumber *LOTTO_TYPE_ID;
@property (strong,nonatomic) NSString *TYPE_NAME;
@property (strong,nonatomic) NSNumber *COMPANY_ID;
@property (strong,nonatomic) NSNumber *COUPBLE;
@property (strong,nonatomic) NSNumber *MULTIPLE;
@property (strong,nonatomic) NSNumber *UNIT;
@property (strong,nonatomic) NSNumber *DAY_ID;
@end
