//
//  XemKQXSModel.h
//  XoSo
//
//  Created by Khoa Le on 7/8/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface XemKQXSModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *RESULT_ID;
@property (strong,nonatomic) NSNumber *COMPANY_ID;
@property (strong,nonatomic) NSNumber *PRIZE_ID;
@property (strong,nonatomic) NSString *RESULT_DATE;
@property (strong,nonatomic) NSString *RESULT_NUMBER;
@property (strong,nonatomic) NSString *RESULT_DESC;
@end
