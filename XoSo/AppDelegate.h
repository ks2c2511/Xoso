//
//  AppDelegate.h
//  XoSo
//
//  Created by Khoa Le on 7/3/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//


#import <UIKit/UIKit.h>

#import <Google/CloudMessaging.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,GGLInstanceIDDelegate>

@property (strong, nonatomic) UIWindow *window;


@property(nonatomic, readonly, strong) NSString *gcmSenderID;
@property(nonatomic, readonly, strong) NSDictionary *registrationOptions;

@end

