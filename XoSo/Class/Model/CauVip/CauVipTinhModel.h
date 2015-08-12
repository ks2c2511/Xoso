//
//  CauVipTinhModel.h
//  XoSo
//
//  Created by Khoa Le on 8/12/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface CauVipTinhModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *COMPANY_ID;
@end
