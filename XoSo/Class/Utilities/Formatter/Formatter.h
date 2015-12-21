//
//  Formatter.h
//  XoSo
//
//  Created by Khoa Le on 12/21/15.
//  Copyright © 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Formatter : NSObject
+(NSDateFormatter *)yyyyMMddDateFormatter;
+(NSDateFormatter *)ddMMyyyyDateFormatter;
@end
