//
//  ThongkeUserController.m
//  XoSo
//
//  Created by Khoa Le on 8/9/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeUserController.h"
#import "ButtonSelect.h"
#import "ThongkeUserCell.h"
#import "ThongkeUserHeader.h"


@interface ThongkeUserController ()
@property (weak, nonatomic) IBOutlet ButtonSelect *buttonDiemcao;
@property (weak, nonatomic) IBOutlet ButtonSelect *buttonTrungcao;
@property (weak, nonatomic) IBOutlet UITextField *textfieldTungay;
@property (weak, nonatomic) IBOutlet UITextField *textDenngay;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contraint_H_Chonngay;
- (IBAction)ChonDiemCao:(id)sender;
- (IBAction)ChonTrungCao:(id)sender;

@end

@implementation ThongkeUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ThongkeUserCell class] forCellReuseIdentifier:NSStringFromClass([ThongkeUserCell class])];
    [self.tableView registerClass:[ThongkeUserHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ThongkeUserHeader class])];
    
    self.imageBackGround.hidden = YES;
    
    self.textfieldTungay.layer.borderColor = [UIColor colorWithRed:174.0/255.0 green:148.0/255.0 blue:71.0/255.0 alpha:1.0].CGColor;
    self.textfieldTungay.layer.borderWidth = 2.0;
    self.textfieldTungay.layer.cornerRadius = 6.0;
    self.textfieldTungay.layer.masksToBounds = YES;
    
    self.textDenngay.layer.borderColor = [UIColor colorWithRed:174.0/255.0 green:148.0/255.0 blue:71.0/255.0 alpha:1.0].CGColor;
    self.textDenngay.layer.borderWidth = 2.0;
    self.textDenngay.layer.cornerRadius = 6.0;
    self.textDenngay.layer.masksToBounds = YES;
    
    self.buttonDiemcao.isSelect = YES;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ThongkeUserHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ThongkeUserHeader class])];
    if (!header) {
        header = [[ThongkeUserHeader alloc] initWithReuseIdentifier:NSStringFromClass([ThongkeUserHeader class])];
    }
    header.contentView.backgroundColor = [UIColor whiteColor];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static ThongkeUserCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeUserCell class])];
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
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (IS_IOS8) {
    //        return UITableViewAutomaticDimension;
    //    }
    return [self heightForBasicCellAtIndexPath:indexPath];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThongkeUserCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkeUserCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(ThongkeUserCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (IBAction)ChonDiemCao:(id)sender {
    
    self.buttonDiemcao.isSelect = YES;
    self.buttonTrungcao.isSelect = NO;
    self.contraint_H_Chonngay.constant = 0;
}

- (IBAction)ChonTrungCao:(id)sender {
    
    self.buttonDiemcao.isSelect = NO;
    self.buttonTrungcao.isSelect = YES;
    self.contraint_H_Chonngay.constant = 70;
}
@end
