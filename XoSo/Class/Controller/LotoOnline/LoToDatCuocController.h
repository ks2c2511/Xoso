//
//  LoToDatCuocController.h
//  XoSo
//
//  Created by Khoa Le on 7/20/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "BaseController.h"
#import "Loto.h"

typedef NS_ENUM(NSInteger, LoaiSoXo) {
    LoaiSoXoLoTo =1,
    LoaiSoXoDacBiet =2,
    LoaiSoXoXien2 = 3,
    LoaiSoXoXien3 = 4
};

@interface LoToDatCuocController : BaseController
@property (strong,nonatomic) Loto *loto;
@end
