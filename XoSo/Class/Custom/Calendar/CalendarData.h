//
//  CalendarData.h
//  VTVCalendarIOS
//
//  Created by Khoa Le on 12/22/14.
//  Copyright (c) 2014 Nguyen Dung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarData : NSObject


@property (nonatomic, strong) NSDateFormatter *weekdayFormatter;
/*********** With index = 0 is recent date ***********/
- (NSArray *)getDaysInWeekWithIndex:(NSInteger)index;
- (void)GetAllDaysWithIndex:(NSInteger)index Done:(void (^)(NSArray *arrayDate, NSArray *arrWeek, int month, int year))done;


+ (NSString *)dateWithMonth:(NSInteger)month Year:(NSInteger)year;
+ (BOOL)checkHasEventWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year;
+ (BOOL)isTodayWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year;
+ (NSString *)getCurrentDate;
+ (NSString *)getCurrentYear;
+ (NSInteger)getCurrentDayOfWeek;
+ (NSDate *)dateWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year;
+ (BOOL)checkDateIsPastWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year;
+ (NSInteger)indexDateWithBeginDate:(NSDate *)begindate Target:(NSDate *)tagget;
+ (NSDate *)setDateWithHour:(NSInteger)hour FromDate:(NSDate *)date;
+ (BOOL)isTodayWithDate:(NSDate *)date;
+ (NSInteger)getHourAndDateIsPastWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year;
+ (NSInteger)getWeekOfDate:(NSDate *)date;
+ (NSInteger)getRecenHour;
@end
