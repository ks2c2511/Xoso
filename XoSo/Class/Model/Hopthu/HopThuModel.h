//
//  HopThuModel.h
//  XoSo
//
//  Created by Khoa Le on 8/19/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface HopThuModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *idHopthu;

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *trung_lo;

@property (nonatomic, copy) NSString *date;


@end
