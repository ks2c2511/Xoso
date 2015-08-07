//
//  ThongkeCapSoModel.h
//  XoSo
//
//  Created by Khoa Le on 8/7/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
@interface ThongkeCapSoModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *phan_tram;
@property (strong,nonatomic) NSString *loto;
@property (strong,nonatomic) NSString *so_lan_xh;
@property (strong,nonatomic) NSString *dacbiet;
@end
