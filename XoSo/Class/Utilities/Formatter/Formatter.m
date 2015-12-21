//
//  Formatter.m
//  XoSo
//
//  Created by Khoa Le on 12/21/15.
//  Copyright © 2015 Khoa Le. All rights reserved.
//

#import "Formatter.h"

@implementation Formatter
+(NSDateFormatter *)yyyyMMddDateFormatter {
    
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    });
    
    return _dateFormatter;
}

+(NSDateFormatter *)ddMMyyyyDateFormatter {
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"dd-MM-yyyy"];
    });
    
    return _dateFormatter;
}
@end
