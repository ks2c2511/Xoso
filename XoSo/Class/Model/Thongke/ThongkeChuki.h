//
//  ThongkeChuki.h
//  XoSo
//
//  Created by Khoa Le on 8/11/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface ThongkeChuki : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *count;
@end
