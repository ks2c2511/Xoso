//
//  Dream.h
//  XoSo
//
//  Created by Khoa Le on 7/10/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Dream : NSManagedObject

@property (nonatomic, retain) NSNumber * dream_id;
@property (nonatomic, retain) NSString * so;
@property (nonatomic, retain) NSString * ten;

@end
