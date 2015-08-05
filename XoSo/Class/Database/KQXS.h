//
//  KQXS.h
//  XoSo
//
//  Created by Khoa Le on 7/24/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KQXS : NSManagedObject

@property (nonatomic, retain) NSString * result_id;
@property (nonatomic, retain) NSString * company_id;
@property (nonatomic, retain) NSString * price_id;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * result_number;
@property (nonatomic, retain) NSString * detail;

@end
