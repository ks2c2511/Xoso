//
//

//  VTVCalendarIOS
//
//  Created by Khoa Le on 12/24/14.
//  Copyright (c) 2014 Nguyen Dung. All rights reserved.
//

#import "Monthcalendar.h"
#import "CalendarData.h"
#import "MonthCell.h"


static NSString *const identifiCell = @"identificell";

@interface Monthcalendar () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelMonthAndYear;
@property (strong,nonatomic) NSDateFormatter *dateFormater;

@property (strong,nonatomic) CalendarData *calendarData;

@property (strong,nonatomic) NSArray *arrayDate;
@property (strong,nonatomic) NSArray *arrayWeek;
@property (assign,nonatomic) NSInteger currentDay;
@property (assign,nonatomic) NSInteger months;
@property (assign,nonatomic) NSInteger years;
- (IBAction)AddAction:(id)sender;

@end

@implementation Monthcalendar

-(id)initWithFrame:(CGRect)frame {
    self = [[NSBundle mainBundle] loadNibNamed:@"Monthcalendar" owner:nil options:nil][0];
    if (self) {
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _currentDay = [[CalendarData getCurrentDate] integerValue];
        
        _calendarData = [[CalendarData alloc] init];
        
        
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 16)];
        }
        
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 16, 0, 16)];
        }
        
    }
    return self;
}

-(void)SetMOnthWithIndex:(NSInteger)index {
    
    _indexMOnth = index;
    [_calendarData GetAllDaysWithIndex:index Done:^(NSArray *arrayDate,NSArray *arrWeek,int month,int year) {
        
        _arrayWeek = arrWeek;
        _arrayDate = arrayDate;
        _months = month;
        _years = year;
        
        
        _labelMonthAndYear.text = [[CalendarData dateWithMonth:month Year:year] uppercaseString];
        [_tableView reloadData];
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _arrayWeek.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MonthCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiCell];
    if (!cell) {
        cell = [[MonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiCell];
        [cell.button1 addTarget:self action:@selector(SelectDate:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button2 addTarget:self action:@selector(SelectDate:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button3 addTarget:self action:@selector(SelectDate:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button4 addTarget:self action:@selector(SelectDate:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button5 addTarget:self action:@selector(SelectDate:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button6 addTarget:self action:@selector(SelectDate:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button7 addTarget:self action:@selector(SelectDate:) forControlEvents:UIControlEventTouchUpInside];
    }
    //cell.labelWeek.text = [_arrayWeek[indexPath.row] stringValue];
    
    NSInteger tag1,tag2,tag3,tag4,tag5,tag6,tag7;
    tag1 = indexPath.row*7 +1;
    tag2 = tag1 +1;
    tag3 = tag2 +1;
    tag4 = tag3 +1;
    tag5 = tag4 +1;
    tag6 = tag5 +1;
    tag7 = tag6 +1;
    
    cell.button1.tag = tag1;
    cell.button2.tag = tag2;
    cell.button3.tag = tag3;
    cell.button4.tag = tag4;
    cell.button5.tag = tag5;
    cell.button6.tag = tag6;
    cell.button7.tag = tag7;
    
    
    for (int i = 1; i <= 7; i++) {
         NSInteger   numbetDate = [_arrayDate[tag1+i -2] integerValue];
//        UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:baseTag+i];
//        img.hidden = YES;
//        if ([CalendarData checkHasEventWithDay:numbetDate Month:_months Year:_years]) {
//            img.hidden = NO;
//        }
        
        UIButton *btn = (UIButton *)[cell.contentView viewWithTag:tag1+i-1];
        btn.hidden = NO;
        btn.backgroundColor = [UIColor clearColor];
        
        [btn setTitle:[_arrayDate[tag1+i-2] stringValue] forState:UIControlStateNormal];
        
        if ([CalendarData isTodayWithDay:numbetDate Month:_months Year:_years]) {
            btn.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:230.0/255.0 blue:166.0/255.0 alpha:1.0];
        }
        else if (![CalendarData checkDateIsPastWithDay:numbetDate Month:_months Year:_years]) {
             btn.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:154.0/255.0 blue:174.0/255.0 alpha:1.0];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else {
            btn.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
            [btn setTitleColor:[UIColor colorWithRed:0.0/255.0 green:22.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        }
        
        if ((numbetDate > 20 && indexPath.row == 0)|| (numbetDate < 8 && indexPath.row >= 3)) {
            btn.hidden = YES;
//            img.hidden = YES;
        }
    }
    
    return cell;
}


-(NSDateFormatter *)dateFormater {
    if (!_dateFormater) {
        _dateFormater = [NSDateFormatter new];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"VI"];
        [_dateFormater setLocale:usLocale];
        [_dateFormater setDateFormat:@"MMMM yyyy"];
        
    }
    
    return _dateFormater;
}

-(void)SelectDate:(UIButton *)button {
    if ([CalendarData checkHourAndDateIsPastWithDay:[_arrayDate[button.tag -1] integerValue] Month:_months Year:_years]) {
        
        if (self.SelectedDate) {
            self.SelectedDate([_arrayDate[button.tag -1] integerValue],_months,_years);
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bạn chỉ chọn được ngày kế tiếp." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
- (IBAction)BackMonth:(id)sender {
    
    [self SetMOnthWithIndex:self.indexMOnth -1];
    
}
- (IBAction)NextMOnth:(id)sender {
    [self SetMOnthWithIndex:self.indexMOnth +1];
}

-(NSInteger)heightCalendar {
    return 90 + self.arrayWeek.count*44;
}
@end
