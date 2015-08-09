//
//  LichsuchoiController.m
//  XoSo
//
//  Created by Khoa Le on 8/9/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LichsuchoiController.h"
#import "ThongkeLichSuChoiCell.h"
#import "ThongkeStore.h"

@interface LichsuchoiController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *arrData;
@end

@implementation LichsuchoiController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Lịch sử chơi loto";
    
    [self.tableView registerClass:[ThongkeLichSuChoiCell class] forCellReuseIdentifier:NSStringFromClass([ThongkeLichSuChoiCell class])];
    
    [ThongkeStore lichsuchoiWithDone:^(BOOL success, NSArray *arr) {
        if (success) {
            self.arrData = arr;
            [self.tableView reloadData];
        }
    }];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource
- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static ThongkeLichSuChoiCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeLichSuChoiCell class])];
    });
    [self configureCell:sizingCell forRowAtIndexPath:indexPath];
    
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (IS_IOS8) {
    //        return UITableViewAutomaticDimension;
    //    }
    return [self heightForBasicCellAtIndexPath:indexPath];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThongkeLichSuChoiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeLichSuChoiCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(ThongkeLichSuChoiCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LichSuChoiModel *model = self.arrData[indexPath.row];
    cell.labelCapso.text = [NSString stringWithFormat:@"%@: %@",model.city,model.capso];
    cell.labelLuottrung.text = [NSString stringWithFormat:@"Lượt trúng: %@/%@",model.trung,model.tong];
    cell.labelName.text = model.username;
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


@end
