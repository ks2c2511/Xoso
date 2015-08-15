//
//  ChatLeverOneModel.h
//  XoSo
//
//  Created by Khoa Le on 8/15/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface ChatLeverOneModel : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSString *subject_id;
@property (strong,nonatomic) NSString *user_name;
@property (strong,nonatomic) NSString *subject_content;
@property (strong,nonatomic) NSString *like_count;
@property (strong,nonatomic) NSString *comment_count;
@property (strong,nonatomic) NSDate *create_date;
@property (strong,nonatomic) NSString *admin;
@end
