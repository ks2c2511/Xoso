//
//  ChatLevelTwoModel.h
//  XoSo
//
//  Created by Khoa Le on 8/15/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface ChatLevelTwoModel : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString *comment_id;
@property (strong,nonatomic) NSString *user_name;
@property (strong,nonatomic) NSString *subject_id;
@property (strong,nonatomic) NSString *comment_content;

@end
