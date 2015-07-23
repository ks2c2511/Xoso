//
//  Loto.h
//  XoSo
//
//  Created by Khoa Le on 7/22/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Loto : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * lototype;
@property (nonatomic, retain) NSNumber * numberbet1;
@property (nonatomic, retain) NSNumber * numberbet2;
@property (nonatomic, retain) NSNumber * numberbet3;
@property (nonatomic, retain) NSNumber * soxu;

@end
