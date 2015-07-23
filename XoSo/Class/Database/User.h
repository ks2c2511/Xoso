//
//  User.h
//  XoSo
//
//  Created by Khoa Le on 7/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * user_name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSString * phone_id;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSNumber * point;
@end
