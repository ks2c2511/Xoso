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

@interface LotoOnlineController ()
@property (strong,nonatomic) Monthcalendar *monthCalendar;
@end

@implementation LotoOnlineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"Chọn ngày đánh cược";
}

-(Monthcalendar *)monthCalendar {
    if (!_monthCalendar) {
        _monthCalendar = [Monthcalendar new];
        [_monthCalendar SetMOnthWithIndex:_monthCalendar.indexMOnth];
        
                __weak typeof(self)weakSelf = self;
        [_monthCalendar setSelectedDate:^(NSInteger day, NSInteger month, NSInteger year) {
            LoToDatCuocController *datcuoc = [LoToDatCuocController new];
            
            LotoResult *loto = [LotoResult new];
            loto.date = [NSString stringWithFormat:@"%li-%li-%li",(long)year,(long)month,(long)day];
            datcuoc.loto = loto;
            [weakSelf.navigationController pushViewController:datcuoc animated:YES];
        }];
        
        [self.view addSubview:_monthCalendar];
    }
    return _monthCalendar;
}

-(void)viewDidAppear:(BOOL)animated {
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
