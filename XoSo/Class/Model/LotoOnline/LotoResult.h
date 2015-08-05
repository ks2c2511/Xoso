//
//  LotoResult.h
//  XoSo
//
//  Created by Khoa Le on 7/28/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotoResult : NSObject
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *provinceId;
@property (strong,nonatomic) NSString *provinceName;
@property (strong,nonatomic) NSString *lotoTypeId;
@property (strong,nonatomic) NSString *lotoTypeName;
@property (strong,nonatomic) NSArray *arrCuoc;
@property (assign,nonatomic) NSInteger numbersocuoc;
@property (assign,nonatomic) NSInteger soxu;
@property (assign,nonatomic) NSInteger unit;
@end
