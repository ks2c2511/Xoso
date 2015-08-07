//
//  ThongkeChuaVeModel.h
//  XoSo
//
//  Created by Khoa Le on 8/7/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, LoaiThongKe) {
    LoaiThongKeDacbiet,
    LoaiThongKeLoto
};

@interface ThongkeChuaVeModel : NSObject
@property (strong, nonatomic) NSString *loaithongke;
@property (assign, nonatomic) LoaiThongKe loai;
@property (strong, nonatomic) NSArray *arrThongke;
@end
