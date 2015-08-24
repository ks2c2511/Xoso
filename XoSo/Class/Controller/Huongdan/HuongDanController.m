//
//  HuongDanController.m
//  XoSo
//
//  Created by Khoa Le on 8/18/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HuongDanController.h"
#import "HuongdanCell.h"
#import "HuongdanModel.h"
#import <IDMPhotoBrowser.h>

@interface HuongDanController () <IDMPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *arrData;
@end

@implementation HuongDanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.homeButtonItem;
    self.navigationItem.title = @"Hướng dẫn";
    
    [self.tableView registerClass:[HuongdanCell class] forCellReuseIdentifier:NSStringFromClass([HuongdanCell class])];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HuongdanCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HuongdanCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(HuongdanCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    HuongdanModel *model = self.arrData[indexPath.row];
    cell.labelTitle.text = model.title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     HuongdanModel *model = self.arrData[indexPath.row];
    
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:[self SaveArrayPhotosWithArray:model.arrNameImage] animatedFromView:self.view]; // using initWithPhotos:animatedFromView: method to use the zoom-in animation
    browser.delegate = self;
    browser.displayActionButton = YES;
    browser.displayArrowButton = YES;
    browser.displayCounterLabel = YES;
    browser.usePopAnimation = YES;
    [browser setInitialPageIndex:indexPath.row];
    
     [self presentViewController:browser animated:YES completion:nil];
}

- (NSArray *)SaveArrayPhotosWithArray:(NSArray *)arrUrl {
    IDMPhoto *photo;
    NSMutableArray *arr = [NSMutableArray new];
    for (id url in arrUrl) {
        photo = [IDMPhoto photoWithImage:[UIImage imageNamed:url]];
       
        
        [arr addObject:photo];
    }
    
    return arr;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(NSArray *)arrData {
    if (!_arrData) {
        _arrData = @[[self modelxoSo],[self modeltaikhoan],[self modelthaoluan],[self modelthongke],[self modelxemKQXS],[self modeldangnhap],[self modeldangki],[self modelchucnangtaikhoan],[self modelchucnanggiaimong]];
    }
    return _arrData;
}

-(HuongdanModel *)modelxoSo {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn chơi xổ số";
    model.arrNameImage = @[@"chon_ngay_choi_loto.png",@"chon_loai_loto.png",@"chon_so_loto.png",@"nhap_tien_choi_loto.png"];
    return model;
}

-(HuongdanModel *)modeltaikhoan {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn nạp tài khoản";
    model.arrNameImage = @[@"chon_loai_sms.png",@"nhan_tin.png",@"nap_the.png"];
    return model;
}
-(HuongdanModel *)modelthaoluan {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn thảo luận";
    model.arrNameImage = @[@"ket_qua_xsoff.PNG"];
    return model;
}

-(HuongdanModel *)modelthongke {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn thống kê";
    model.arrNameImage = @[@"thongke1.PNG",@"tk2.PNG"];
    return model;
}

-(HuongdanModel *)modelxemKQXS {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn xem KQXS online - offline";
    model.arrNameImage = @[@"help_result.PNG"];
    return model;
}

-(HuongdanModel *)modeldangnhap {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn đăng nhập";
    model.arrNameImage = @[@"help_result.PNG",@"login2.JPG"];
    return model;
}

-(HuongdanModel *)modeldangki {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn đăng kí";
    model.arrNameImage = @[@"dangki1.JPG",@"dangki2.JPG"];
    return model;
}

-(HuongdanModel *)modelchucnangtaikhoan {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn chức năng tài khoản";
    model.arrNameImage = @[@"taikhoan1.JPG",@"taikhoan2.JPG",@"taikoan3.JPG"];
    return model;
}

-(HuongdanModel *)modelchucnanggiaimong {
    HuongdanModel *model = [HuongdanModel new];
    model.title = @"Hướng dẫn chức năng giải mộng";
    model.arrNameImage = @[@"dream1.JPG",@"dream2.JPG"];
    return model;
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
