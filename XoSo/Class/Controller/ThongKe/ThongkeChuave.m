//
//  ThongkeChuave.m
//  XoSo
//
//  Created by Khoa Le on 8/5/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeChuave.h"
#import "ThongkeChuaVeCell.h"
#import "ThongkeChuaVeHeader.h"
#import "ThongkeStore.h"
#import "ThongkeChuaVeModel.h"

@interface ThongkeChuave ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *arrData;
@end

@implementation ThongkeChuave

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[ThongkeChuaVeCell class] forCellWithReuseIdentifier:NSStringFromClass([ThongkeChuaVeCell class])];
    [self.collectionView registerClass:[ThongkeChuaVeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ThongkeChuaVeHeader class])];


    [ThongkeStore thongkeWithLuotQuay:self.luotquay MaTinh:self.matinh Xem:thong_ke_chuave Type:thong_ke_type_dac_biet Done: ^(BOOL success, NSArray *arr) {
        NSMutableArray *arrAll = [NSMutableArray new];
        if (success) {
            ThongkeChuaVeModel *model = [ThongkeChuaVeModel new];
            model.loaithongke = @"Đặc biệt";
            model.loai = LoaiThongKeDacbiet;
            model.arrThongke = arr;
            [arrAll addObject:model];
        }

        [ThongkeStore thongkeWithLuotQuay:self.luotquay MaTinh:self.matinh Xem:thong_ke_chuave Type:thong_ke_type_loto Done: ^(BOOL success, NSArray *arrLoto) {
            if (success) {
                ThongkeChuaVeModel *lotomodel = [ThongkeChuaVeModel new];
                lotomodel.loaithongke = @"Lô tô";
                lotomodel.loai = LoaiThongKeLoto;
                lotomodel.arrThongke = arrLoto;
                [arrAll addObject:lotomodel];
            }
            self.arrData = arrAll;
            [self.collectionView reloadData];
        }];
    }];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - collectionView Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(self.view.frame), 30);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.arrData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.arrData[section] arrThongke] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ThongkeChuaVeHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ThongkeChuaVeHeader class]) forIndexPath:indexPath];

        ThongkeChuaVeModel *model = self.arrData[indexPath.section];
        if (model.loai == LoaiThongKeDacbiet) {
            headerView.labelHeader.textColor = [UIColor redColor];
            headerView.labelHeader.text = model.loaithongke;
        }
        else {
            headerView.labelHeader.textColor = [UIColor colorWithRed:125.0/255.0 green:174.0/255.0 blue:166.0/255.0 alpha:1.0];
            headerView.labelHeader.text = model.loaithongke;
        }

        return headerView;
    }

    return nil;
}

- (CGSize)  collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float sizeWidth = [[UIScreen mainScreen] bounds].size.width / 8- 9;

    return CGSizeMake(sizeWidth, sizeWidth /1.5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThongkeChuaVeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ThongkeChuaVeCell class]) forIndexPath:indexPath];

    ThongkeChuaVeModel *model = self.arrData[indexPath.section];
    ThongkeCapSoModel *capso = model.arrThongke[indexPath.row];
    if (model.loai == LoaiThongKeDacbiet) {
        cell.labelNumber.backgroundColor = [UIColor colorWithRed:180.0/255.0 green:44.0/255.0 blue:42.0/255.0 alpha:1.0];
        cell.labelNumber.text = capso.dacbiet;
    }
    else {
        cell.labelNumber.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:131.0/255.0 blue:109.0/255.0 alpha:1.0];
        cell.labelNumber.text = capso.loto;

    }

    return cell;
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
