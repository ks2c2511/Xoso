
//
//  HopThuController.m
//  XoSo
//
//  Created by Khoa Le on 8/18/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HopThuController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "HopThuCell.h"
#import "HopThuStore.h"
#import <UIAlertView+Blocks.h>

@interface HopThuController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong,nonatomic) NSArray *arrData;
@end

@implementation HopThuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Hòm thư";
    self.navigationItem.leftBarButtonItem = self.homeButtonItem;
    self.bannerView.adUnitID = google_id_Ad;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    [self.tableView registerClass:[HopThuCell class] forCellReuseIdentifier:NSStringFromClass([HopThuCell class])];
    self.tableView.tableFooterView = [UIView new];
    
    [HopThuStore GetEmailWithType:1 Done:^(BOOL success, NSArray *arr) {
        if (success) {
            _arrData = arr;
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
    return 65;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HopThuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HopThuCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(HopThuCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    HopThuModel *model = self.arrData[indexPath.row];
    cell.labelTitle.text = model.subject;
    cell.abelTime.text = model.date;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     HopThuModel *model = self.arrData[indexPath.row];
    
    [UIAlertView showWithTitle:[NSString stringWithFormat:@"%@ (%@)",model.subject,model.date] message:model.content cancelButtonTitle:@"OK" otherButtonTitles:@[@"Xoá"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
        if (buttonIndex == 1) {
            
        }
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
