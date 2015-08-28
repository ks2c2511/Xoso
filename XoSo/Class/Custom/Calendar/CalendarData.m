//
//  CalendarData.m
//  VTVCalendarIOS
//
//  Created by Khoa Le on 12/22/14.
//  Copyright (c) 2014 Nguyen Dung. All rights reserved.

#import "CalendarData.h"

#define MAX_MONTH 12
#define MIN_MONTH 1

@interface CalendarData () {
}
@end

@implementation CalendarData




#pragma mark - return Array Of Day in Week (Array of NSDate)
- (NSArray *)getDaysInWeekWithIndex:(NSInteger)index {
    NSDate *weekDate = [[NSDate date] dateByAddingTimeInterval:index * 7 * 24 * 60 * 60];
    NSCalendar *myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [myCalendar components:NSYearForWeekOfYearCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit fromDate:weekDate];

    NSMutableArray *arrayDate = [NSMutableArray arrayWithCapacity:7];
    for (int i = 1; i <= 7; i++) {
        [comps setWeekday:i]; // 1: sunday,7:saturday

        [arrayDate addObject:[myCalendar dateFromComponents:comps]];
    }
    return arrayDate;
}

#pragma mark - Make Array Days in Month

- (void)GetAllDaysWithIndex:(NSInteger)index Done:(void (^)(NSArray *arrayDate, NSArray *arrWeek, int month, int year))done {
    NSDate *today = [NSDate date];

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = index;
    NSDate *nextMonth = [gregorian dateByAddingComponents:components toDate:today options:0];

    NSDateComponents *nextMonthComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:nextMonth];

    [self GetAllDaysWithMonth:(long)nextMonthComponents.month Year:(long)nextMonthComponents.year Done: ^(NSArray *arrayDate) {
        done(arrayDate, [self weeksOfMonth:nextMonthComponents.month inYear:nextMonthComponents.year], nextMonthComponents.month, nextMonthComponents.year);
    }];
}

- (void)GetAllDaysWithMonth:(NSInteger)month Year:(NSInteger)year Done:(void (^)(NSArray *arrayDate))done {
    /*********** count All Day only has 3 value is 28,35,42 ***********/
    int countAllday;

    NSUInteger numberDayOfMonth = [CalendarData getDaysInMonth:(long)month year:(long)year];


    /*********** check 1st of this month is what day and get index of it (With index's monday is 0 to index of sunday is 6) ***********/
    NSString *oneSt = [CalendarData getDayOfDate:1 month:month year:year];

    NSArray *daysInWeeks = [[NSArray alloc]initWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];

    NSUInteger indexDayOfmonth = [daysInWeeks indexOfObject:oneSt];
    /*********** measure number of day show in a month  ***********/
    NSUInteger alldayestimate = numberDayOfMonth + indexDayOfmonth;

    if (alldayestimate <= 28) {
        countAllday = 28;
    }
    else if (alldayestimate <= 35) {
        countAllday = 35;
    }
    else {
        countAllday = 42;
    }

    NSMutableArray *arrayDay = [NSMutableArray arrayWithCapacity:countAllday];
    /*********** Add Day Of Pre month ***********/

    if (indexDayOfmonth != 0) {
        NSUInteger indexOfEndDayInPreMonth = indexDayOfmonth - 1;

        double numberDayOfPreMonth = [self numberDayofPreMonthWithMonth:month Year:year];

        for (int i = 0; i <= indexOfEndDayInPreMonth; i++) {
            [arrayDay addObject:@(numberDayOfPreMonth - indexOfEndDayInPreMonth + i)];
        }
    }

    /*********** Add days of recent month ***********/
    for (int j = 1; j <= numberDayOfMonth; j++) {
        [arrayDay addObject:@(j)];
    }

    /*********** Add Day of next month ***********/
    NSUInteger numberDayNextMonth = countAllday - alldayestimate;

    if (numberDayNextMonth != 0) {
        for (int k = 1; k <= numberDayNextMonth; k++) {
            [arrayDay addObject:@(k)];
        }
    }

    done(arrayDay);
}

- (NSArray *)weeksOfMonth:(NSInteger)month inYear:(NSInteger)year {
    NSCalendar *mycalendar = [NSCalendar currentCalendar];
    [mycalendar setFirstWeekday:1];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:month];
    [components setYear:year];

    NSRange range = [mycalendar rangeOfUnit:NSDayCalendarUnit
                                     inUnit:NSMonthCalendarUnit
                                    forDate:[mycalendar dateFromComponents:components]];

    mycalendar = [NSCalendar currentCalendar];
    [mycalendar setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableArray *weeks = [NSMutableArray array];

    for (int i = 0; i < range.length; i++) {
        NSString *temp = [NSString stringWithFormat:@"%4ld-%2ld-%2lu", (long)year, (long)month, range.location + i];
        NSDate *date = [dateFormatter dateFromString:temp];
        int week = (int)[[mycalendar components:NSWeekOfYearCalendarUnit fromDate:date] weekOfYear];
        [weeks addObject:[NSNumber numberWithInt:week]];
    }
    NSArray *newArray = [[NSOrderedSet orderedSetWithArray:weeks] array];
    return newArray;
}

- (NSUInteger)numberDayofPreMonthWithMonth:(NSInteger)month Year:(NSInteger)year {
    NSUInteger numberday;
    NSInteger preMonth = month - 1;
    NSInteger preYear = year;
    if (preMonth < MIN_MONTH) {
        preMonth = MAX_MONTH;
        preYear -= 1;
    }
    numberday = [CalendarData getDaysInMonth:preMonth year:preYear];

    return numberday;
}

+ (int)getDaysInMonth:(NSInteger)month year:(NSInteger)year {
    int daysInFeb = 28;
    if (year % 4 == 0) {
        daysInFeb = 29;
    }
    int daysInMonth[12] = { 31, daysInFeb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    return daysInMonth[month - 1];
}

+ (NSString *)getDayOfDate:(int)date month:(int)month year:(int)year {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [dateFormatter setCalendar:gregorianCalendar];

    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];

    NSDate *capturedStartDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%04i-%02i-%02i", year, month, date]];

    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setLocale:usLocale];
    [weekday setDateFormat:@"EEEE"];

    return [weekday stringFromDate:capturedStartDate];
}

+ (NSString *)dateWithMonth:(NSInteger)month Year:(NSInteger)year {
    NSArray *arr = @[@"THÁNG MỘT", @"THÁNG HAI", @"THÁNG BA", @"THÁNG TƯ", @"THÁNG NĂM", @"THÁNG SÁU", @"THÁNG BẢY", @"THÁNG TÁM", @"THÁNG CHÍN", @"THÁNG MƯỜI", @"THÁNG MƯỜI MỘT", @"THÁNG MƯỜI HAI"];

    return [NSString stringWithFormat:@"%@ %li", arr[month - 1], (long)year];
}

+ (BOOL)checkHasEventWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year {
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    components.day = day;
    components.month = month;
    components.year = year;
    NSDate *otherDate = [calendar dateFromComponents:components];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@", otherDate];


    return NO;
}

+ (BOOL)isTodayWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year {
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];

    NSDate *today = [calendar dateFromComponents:components];
    components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    components.day = day;
    components.month = month;
    components.year = year;
    NSDate *otherDate = [calendar dateFromComponents:components];

    if ([today isEqualToDate:otherDate]) {
        return YES;
    }
    else {
        return NO;
    }

    return NO;
}

+ (NSString *)getCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];

    [formatter setCalendar:gregorianCalendar];
    [formatter setDateFormat:@"dd"];
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSString *)getCurrentYear {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];

    [formatter setCalendar:gregorianCalendar];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSInteger)indexDateWithBeginDate:(NSDate *)begindate Target:(NSDate *)tagget {
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:begindate];

    NSInteger beginday = components.day;

    components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:tagget];

    NSInteger targetDay = components.day;

    return targetDay - beginday;
}

+ (NSDate *)setDateWithHour:(NSInteger)hour FromDate:(NSDate *)date {
    unsigned unitFlags = kCFCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | kCFCalendarUnitHour;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    comps.hour   = hour;
    comps.minute = 0.0;
    comps.second = 0.0;
    NSDate *newDate = [calendar dateFromComponents:comps];

    //    NSDateComponents* comps = [[NSDateComponents alloc]init];
    //    comps.hour = hour;
    //
    //    NSCalendar* calendar = [NSCalendar currentCalendar];

    return newDate;
}

+ (NSDate *)dateWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year {
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    comps.day = day;
    comps.month = month;
    comps.year = year;

    NSCalendar *calendar = [NSCalendar currentCalendar];

    return [calendar dateFromComponents:comps];
}

+ (BOOL)isTodayWithDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];

    NSDate *today = [calendar dateFromComponents:components];
    components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    NSDate *otherDate = [calendar dateFromComponents:components];

    if ([today isEqualToDate:otherDate]) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)checkDateIsPastWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year {
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];

    NSDate *today = [calendar dateFromComponents:components];

    components.day = day;
    components.month = month;
    components.year = year;
    NSDate *otherDate = [calendar dateFromComponents:components];


    NSComparisonResult result = [today compare:otherDate];

    if (result == NSOrderedAscending) {
        return YES;
    }

    else if (result == NSOrderedDescending) {
        return NO;
    }

    else
        return YES;
}

+ (NSInteger)getHourAndDateIsPastWithDay:(NSInteger)day Month:(NSInteger)month Year:(NSInteger)year {
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit) fromDate:[NSDate date]];
    components.day = day;
    components.month = month;
    components.year = year;

    return components.hour;
}

+ (NSInteger)getRecenHour {
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit) fromDate:[NSDate date]];

    return components.hour;
}

+ (NSInteger)getWeekOfDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.firstWeekday = 1; // Sunday = 1, Saturday = 7

    NSDateComponents *components = [gregorian components:NSWeekOfYearCalendarUnit fromDate:date];

    return [components weekOfYear];
}

@end
