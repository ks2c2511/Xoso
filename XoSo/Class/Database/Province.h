//
//  Province.h
//  XoSo
//
//  Created by Khoa Le on 7/10/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Province : NSManagedObject

@property (nonatomic, retain) NSNumber * province_id;
@property (nonatomic, retain) NSNumber * province_group;
@property (nonatomic, retain) NSString * province_name;
@property (nonatomic, retain) NSNumber * check_city;

@end
