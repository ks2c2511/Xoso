//
//  LoToDatCuocController.m
//  XoSo
//
//  Created by Khoa Le on 7/20/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LoToDatCuocController.h"
#import "ChonCuocController.h"
#import "CustomSegment.h"
#import "ButtonBorder.h"
#import "ChontinhCell.h"
#import <GzDateFormatter.h>
#import "LotoOnlineStore.h"
#import "ChonTypeCollectionCellCollectionViewCell.h"
#import "Province.h"
#import <IQKeyboardManager.h>
@interface LoToDatCuocController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSArray *arrData;
@property (strong,nonatomic) LotoRegionModel *currentModel;
@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (IBAction)CloseView:(UITapGestureRecognizer *)sender;

@end

@implementation LoToDatCuocController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popUpView.alpha = 0;
    
    [self.tableView registerClass:[ChontinhCell class] forCellReuseIdentifier:NSStringFromClass([ChontinhCell class])];
    [self.collectionView registerClass:[ChonTypeCollectionCellCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ChonTypeCollectionCellCollectionViewCell class])];
    
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:100];
    
    [LotoOnlineStore getLotoTypeWithDate:self.loto.date Done:^(BOOL success, NSArray *arrData) {
        
        if (success && arrData.count != 0) {
            self.arrData = arrData;
            self.currentModel = arrData[0];
            
            if (self.currentModel.arrLotoType.count != 0) {
                LotoTypeModel *model = self.currentModel.arrLotoType[0];
                self.loto.lotoTypeId = [NSString stringWithFormat:@"%@",model.LOTTO_TYPE_ID];
                self.loto.lotoTypeName = model.TYPE_NAME;
                self.loto.numbersocuoc = [model.COUPBLE integerValue];
                self.loto.unit = [model.UNIT integerValue];
            }
            if (self.currentModel.arrProvince.count != 0) {
                Province *model = self.currentModel.arrProvince[0];
                self.loto.provinceId = [NSString stringWithFormat:@"%@",model.province_id];
                self.loto.provinceName = model.province_name;
            }
           
            [self.collectionView reloadData];
            [self.tableView reloadData];
        }
       
        
    }];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated {
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width -16 )/4, 39);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.currentModel.arrLotoType.count;
    
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChonTypeCollectionCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ChonTypeCollectionCellCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.labelType.text = [self.currentModel.arrLotoType[indexPath.row] TYPE_NAME];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LotoTypeModel *model = self.currentModel.arrLotoType[indexPath.row];
    self.loto.lotoTypeId = [NSString stringWithFormat:@"%@",model.LOTTO_TYPE_ID];
    self.loto.lotoTypeName = model.TYPE_NAME;
    self.loto.numbersocuoc = [model.COUPBLE integerValue];
    self.loto.unit = [model.UNIT integerValue];
    
    ChonCuocController *choncuoc = [ChonCuocController new];
    choncuoc.loto =self.loto;
    [self.navigationController pushViewController:choncuoc animated:YES];

}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentModel.arrProvince.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChontinhCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChontinhCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    
    return cell;
}

- (void)configureCell:(ChontinhCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Province *model = self.currentModel.arrProvince[indexPath.row];
    [cell.buttonChonTinh setTitle:model.province_name forState:UIControlStateNormal];
    cell.buttonChonTinh.tag = indexPath.row;
    [cell.buttonChonTinh addTarget:self action:@selector(ChonTinh:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (IBAction)SelectSecment:(CustomSegment *)sender {
    
    self.currentModel = self.arrData[sender.selectedSegmentIndex];
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
    
    self.popUpView.alpha =1;
   
}

-(void)ChonTinh:(UIButton *)btn {
    Province *model = self.currentModel.arrProvince[btn.tag];
    self.loto.provinceId = [NSString stringWithFormat:@"%@",model.province_id];
    self.loto.provinceName = model.province_name;
    
    self.popUpView.alpha = 0;
}

- (IBAction)SelectLoaiSoXo:(ButtonBorder *)sender {
    
   }



-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CloseView:(UITapGestureRecognizer *)sender {
    self.popUpView.alpha = 0;
}
@end
