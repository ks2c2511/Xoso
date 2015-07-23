//
//  Notifi.h
//  XoSo
//
//  Created by Khoa Le on 7/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notifi : NSManagedObject

@property (nonatomic, retain) NSString * thongbao;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSNumber * reducemonney;

@end
