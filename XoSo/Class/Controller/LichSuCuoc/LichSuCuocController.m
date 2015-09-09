//
//  LichSuCuocController.m
//  XoSo
//
//  Created by Khoa Le on 7/26/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LichSuCuocController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "LichSuChoiCell.h"
#import "HistoryStore.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
@interface LichSuCuocController () {
    NSInteger currentPage;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong,nonatomic) NSArray *arrData;
@property (strong,nonatomic) NSDateFormatter *submitDateFormat;
@property (strong,nonatomic) NSDateFormatter *dateFormat;
@end

@implementation LichSuCuocController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Lịch sử cá cược";
    
    _tableView.tableFooterView = [UIView new];
    
    currentPage= 1;
    
    self.bannerView.adUnitID = google_id_Ad;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    [self.tableView registerClass:[LichSuChoiCell class] forCellReuseIdentifier:NSStringFromClass([LichSuChoiCell class])];
    
    [HistoryStore getHistoryWithPage:currentPage Done:^(BOOL success, NSArray *data) {
        if (success) {
            if (self.showFutureCuoc) {
                NSPredicate *pre  = [NSPredicate predicateWithFormat:@"STATUS == %@",[NSString stringWithFormat:@"%i",1]];
                _arrData = [data filteredArrayUsingPredicate:pre];
            }
            else {
                _arrData = data;
            }
            
             [self.tableView reloadData];
        }
       
    }];
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.triggerVerticalOffset = 10;
    refreshControl.tintColor = [UIColor blackColor];
    refreshControl.attributedTitle = [[NSAttributedString alloc]
                                      initWithString:@"Tải thêm"
                                      attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    [refreshControl addTarget:self
                       action:@selector(refresh:)
             forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl = refreshControl;
    // Do any additional setup after loading the view from its nib.
}

-(void)refresh:(UIRefreshControl *)refrest {
    currentPage +=1;
    [HistoryStore getHistoryWithPage:currentPage Done:^(BOOL success, NSArray *data) {
        
        [refrest endRefreshing];
        if (success) {
            if (self.showFutureCuoc) {
                NSPredicate *pre  = [NSPredicate predicateWithFormat:@"STATUS == %@",[NSString stringWithFormat:@"%i",1]];
                _arrData = [data filteredArrayUsingPredicate:pre];
            }
            else {
                NSMutableArray *muArr = [NSMutableArray arrayWithArray:_arrData];
                [muArr addObjectsFromArray:data];
                
                
                NSMutableArray *muArrIndexpaths = [NSMutableArray new];
                for (int i = (int)_arrData.count; i < muArr.count; i ++) {
                    [muArrIndexpaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                }
                
                
                
                _arrData = muArr;
                
                [self.tableView insertRowsAtIndexPaths:muArrIndexpaths withRowAnimation:UITableViewRowAnimationAutomatic];
                muArr = nil;
                muArrIndexpaths = nil;
            }
            
            [self.tableView reloadData];
        }
        
    }];
}

#pragma mark - UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (IS_IOS8) {
    //        return UITableViewAutomaticDimension;
    //    }
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LichSuChoiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LichSuChoiCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(LichSuChoiCell   *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HistoryModel *model = self.arrData[indexPath.row];
    
    BOOL quayso = ([model.STATUS integerValue] == 1)?YES:NO;
    [cell setTextForCellWithDate:model.DATE NameCity:model.COMPANY_NAME LotoName:model.TYPE_NAME DaySoDatCuoc:model.LOTTO_NUMBER SoXu:[NSString stringWithFormat:@"%@",model.POINT_NUMBER] Trung:[model.ITERATIONS boolValue] ChuaQuaySo:quayso SoxuNhan:[NSString stringWithFormat:@"%@",model.POINT_REVEICED]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDateFormatter *)dateFormat {
    if (!_dateFormat) {
        _dateFormat = [NSDateFormatter new];
        _dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        _dateFormat.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [_dateFormat setDateFormat:@"dd-MM-yyyy"];
    }
    return _dateFormat;
}

-(NSDateFormatter *)submitDateFormat {
    if (!_submitDateFormat) {
        _submitDateFormat = [NSDateFormatter new];
        _submitDateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        _submitDateFormat.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [_submitDateFormat setDateFormat:@"yyyy-MM-dd"];
    }
    return _submitDateFormat;
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
