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
@interface LichSuCuocController () {
    NSInteger currentPage;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong,nonatomic) NSArray *arrData;
@end

@implementation LichSuCuocController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Lịch sử cá cược";
    
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
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource
//- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
//    static <#Cell#> *sizingCell = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sizingCell = [self.locationPickerView.tableView dequeueReusableCellWithIdentifier:<#identifi#>];
//    });
//    [self configureCell:sizingCell forRowAtIndexPath:indexPath];
//    
//    return [self calculateHeightForConfiguredSizingCell:sizingCell];
//}
//
//- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
//    [sizingCell setNeedsLayout];
//    [sizingCell layoutIfNeeded];
//    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height;
//}


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
    [cell setTextForCellWithDate:model.DATE NameCity:model.COMPANY_NAME LotoName:model.TYPE_NAME DaySoDatCuoc:model.LOTTO_NUMBER SoXu:[NSString stringWithFormat:@"%@",model.POINT_NUMBER] Trung:[model.ITERATIONS boolValue] ChuaQuaySo:quayso];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
