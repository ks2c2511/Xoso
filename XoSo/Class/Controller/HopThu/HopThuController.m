
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
    self.navigationItem.title = @"Hộp thư";
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
    Hopthu *model = self.arrData[indexPath.row];
    if (!model.daxem) {
        [cell.imageLogo setImage:[UIImage imageNamed:@"email_icon1.png"]];
        cell.labelTitle.textColor = [UIColor colorWithRed:20.0/255.0 green:112.0/255.0 blue:206.0/255.0 alpha:1.0];
    }
    else {
        [cell.imageLogo setImage:[UIImage imageNamed:@"email_icon2.png"]];
        cell.labelTitle.textColor = [UIColor colorWithRed:138.0/255.0 green:138.0/255.0 blue:138.0/255.0 alpha:1.0];
    }
    
    cell.labelTitle.text = model.subject;
    cell.abelTime.text = model.date;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     Hopthu *model = self.arrData[indexPath.row];
    
    [UIAlertView showWithTitle:[NSString stringWithFormat:@"%@ (%@)",model.subject,model.date] message:model.content cancelButtonTitle:@"OK" otherButtonTitles:@[@"Xoá"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
        if (buttonIndex == 1) {
            [model DeleteThis];
            self.arrData = [Hopthu fetchAll];
            [self.tableView reloadData];
        }
        else {
            model.daxem = @(YES);
            [model saveToPersistentStore];
            [Hopthu fetchAllWithBlock:^(BOOL succeeded, NSArray *objects) {
                self.arrData = objects;
                [self.tableView reloadData];
            }];
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
