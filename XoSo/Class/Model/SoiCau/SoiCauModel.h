//
//  SoiCauModel.h
//  XoSo
//
//  Created by Khoa Le on 8/12/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface SoiCauModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *TK_ID;
@property (strong,nonatomic) NSString *TK_MATINH;
@property (strong,nonatomic) NSString *TK_DATE;
@property (strong,nonatomic) NSString *TK_DAU;
@property (strong,nonatomic) NSString *TK_DUOI;
@property (strong,nonatomic) NSString *TK_DB;
@property (strong,nonatomic) NSString *TK_LOTO;
@property (strong,nonatomic) NSString *TK_XIEN;
@end
