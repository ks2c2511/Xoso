//
//  Ads.h
//  XoSo
//
//  Created by Khoa Le on 7/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Ads : NSManagedObject

@property (nonatomic, retain) NSString * id_ad;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * image;

@end
