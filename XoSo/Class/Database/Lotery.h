//
//  Lotery.h
//  XoSo
//
//  Created by Khoa Le on 9/5/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Lotery : NSManagedObject

@property (nonatomic, retain) NSNumber * company_id;
@property (nonatomic, retain) NSNumber * day_id;
@property (nonatomic, retain) NSNumber * lotery_id;

@end
