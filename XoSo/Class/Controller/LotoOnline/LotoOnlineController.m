//
//  LotoOnlineController.m
//  XoSo
//
//  Created by Khoa Le on 7/11/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LotoOnlineController.h"
#import "Monthcalendar.h"
#import "LoToDatCuocController.h"
#import "CalendarData.h"
#import "LotoResult.h"
#import <UIAlertView+Blocks.h>
#import "NSDate+Category.h"
@interface LotoOnlineController ()
@property (strong, nonatomic) Monthcalendar *monthCalendar;
@property (assign, nonatomic) BOOL isBac, isTrung, isNam;
@end

@implementation LotoOnlineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"Chọn ngày đánh cược";
}

- (Monthcalendar *)monthCalendar {
    if (!_monthCalendar) {
        _monthCalendar = [Monthcalendar new];
        [_monthCalendar SetMOnthWithIndex:_monthCalendar.indexMOnth];

        _isBac = YES;
        _isTrung = YES;
        _isNam = YES;
        __weak typeof(self) weakSelf = self;

        [_monthCalendar setSelectedDate: ^(NSInteger day, NSInteger month, NSInteger year) {
            if ([CalendarData isTodayWithDay:day Month:month Year:year]) {
                if ([[NSDate date] hour] >= 18 ) {
                    [UIAlertView showWithTitle:@"Thông báo" message:@"Đã quá giờ quay số. Bác vui lòng chọn ngày khác." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                }
                else {
                        if ([[NSDate date] hour] >= 16 && [[NSDate date] hour] < 17) {
                            weakSelf.isBac = YES;
                            weakSelf.isTrung = YES;
                            weakSelf.isNam = NO;
                        }
                        else if ([[NSDate date] hour] >= 17 && [[NSDate date] hour] < 18) {
                            weakSelf.isBac = YES;
                            weakSelf.isTrung = NO;
                            weakSelf.isNam = NO;
                        }
                        else if ([[NSDate date] hour] >= 18 ) {
                            [UIAlertView showWithTitle:@"Thông báo" message:@"Đã quá giờ quay số. Bác vui lòng chọn ngày khác." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                            return;
                        }

                        else {
                            weakSelf.isBac = YES;
                            weakSelf.isTrung = YES;
                            weakSelf.isNam = YES;
                        }

                    LoToDatCuocController *datcuoc = [LoToDatCuocController new];

                    LotoResult *loto = [LotoResult new];
                    loto.date = [NSString stringWithFormat:@"%li-%li-%li", (long)year, (long)month, (long)day];
                    datcuoc.loto = loto;
                    datcuoc.isBac = weakSelf.isBac;
                    datcuoc.isTrung = weakSelf.isTrung;
                    datcuoc.isNam = weakSelf.isNam;
                    [weakSelf.navigationController pushViewController:datcuoc animated:YES];
                }
            }
            else {
                LoToDatCuocController *datcuoc = [LoToDatCuocController new];

                LotoResult *loto = [LotoResult new];
                loto.date = [NSString stringWithFormat:@"%li-%li-%li", (long)year, (long)month, (long)day];
                datcuoc.loto = loto;
                datcuoc.isBac = weakSelf.isBac;
                datcuoc.isTrung = weakSelf.isTrung;
                datcuoc.isNam = weakSelf.isNam;
                [weakSelf.navigationController pushViewController:datcuoc animated:YES];
            }
        }];

        [self.view addSubview:_monthCalendar];
    }
    return _monthCalendar;
}

- (void)viewDidAppear:(BOOL)animated {
    self.monthCalendar.frame = ({
        CGRect frame = self.view.bounds;
        frame.origin.y = 0;
        frame;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
