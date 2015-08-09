//
//  ThongKeDiemCaoModel.h
//  XoSo
//
//  Created by Khoa Le on 8/9/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface ThongKeDiemCaoModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *sumpoint;
@end
