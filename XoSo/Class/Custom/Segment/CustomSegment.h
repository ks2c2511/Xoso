//
//  CustomSegment.h
//  NHSNottingham
//
//  Created by Khoa Le on 5/13/14.
//  Copyright (c) 2014 Khoa Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegment : UISegmentedControl

@property (nonatomic, strong) UIFont *FFont;

// text color
@property (nonatomic, strong) UIColor *FColor;
@property (nonatomic,strong) UIColor *FSelectionTextColor;

// backgroung color
@property (nonatomic,strong) UIColor *FSelectColor;
@property (nonatomic,strong) UIColor *FBackgroundColor;

// line color
@property (nonatomic,strong) UIColor *FLineColor;

@property (nonatomic, assign) float Fheight;
@property (nonatomic,assign) float FWidthUnderLine;
@property (nonatomic,assign) float FWidthSeparator;
@property (nonatomic,assign) float FWidthSelectLine;

@property (nonatomic,strong) UIImageView *selectLine;


@end
