//
//  Monthcalendar.h
//  VTVCalendarIOS
//
//  Created by Khoa Le on 12/24/14.
//  Copyright (c) 2014 Nguyen Dung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Monthcalendar : UIView

@property (assign,nonatomic) NSInteger heightCalendar;
@property(copy) void (^SelectedDate)(NSInteger day, NSInteger month, NSInteger year);

@property (assign,nonatomic) NSInteger indexMOnth; // 0 is recent Month,-1 is pre month, 1 s next month
-(void)SetMOnthWithIndex:(NSInteger)index;
@end
