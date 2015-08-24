//
//  Hopthu.h
//  XoSo
//
//  Created by Khoa Le on 8/20/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Hopthu : NSManagedObject

@property (nonatomic, retain) NSString * idHopthu;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * trung_lo;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * daxem;

@end
