//
//  CustomBanner.m
//  XoSo
//
//  Created by Khoa Le on 9/21/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "CustomBanner.h"


@interface CustomBanner () {
    STABannerView *bannerView;
}

@end
@implementation CustomBanner

- (id)init {
    self = [super init];

    return self;
}

- (void)awakeFromNib {
    if (bannerView == nil) {
        bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Top
                                                withView:self withDelegate:nil];
        [self addSubview:bannerView];
    }
}

@end
