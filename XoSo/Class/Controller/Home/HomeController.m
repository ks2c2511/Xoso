//
//  HomeController.m
//  XoSo
//
//  Created by Khoa Le on 7/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "HomeController.h"
#import "HomeCollectionCell.h"
#import "UIColor+AppTheme.h"
#import "XemKQXSController.h"


static NSString *identifi_HomeCollectionCell = @"identifi_HomeCollectionCell";
@interface HomeController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSArray *arrData;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:identifi_HomeCollectionCell];
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = self.menuButtonItem;
    self.navigationItem.titleView = self.labelNavigationTitleRun;
}

#pragma mark - collectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width/3 -4, 78);
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifi_HomeCollectionCell forIndexPath:indexPath];
    cell.labelTitle.text = self.arrData[indexPath.row][@"title"];
    
    if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"cau_vip"] || [self.arrData[indexPath.row][@"key"] isEqualToString:@"kiem_xu"]) {
        [cell.imageLogo setImage:[UIImage animatedImageNamed:self.arrData[indexPath.row][@"iconname"] duration:1.0]];
        cell.imageLogo.animationRepeatCount = 0;
        [cell.imageLogo startAnimating];
        
    }
    else {
         [cell.imageLogo setImage:[UIImage imageNamed:self.arrData[indexPath.row][@"iconname"]]];
    }
   
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    HomeCollectionCell *cell = (HomeCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor appOrange];
    
    [UIView animateWithDuration:.35 animations:^{
        cell.contentView.backgroundColor = [UIColor clearColor];
    }];
    
    if ([self.arrData[indexPath.row][@"key"] isEqualToString:@"xem_kqxs"]) {
        XemKQXSController *kqxs = [XemKQXSController new];
        [self.navigationController pushViewController:kqxs animated:YES];
    }
    
}


-(NSArray *)arrData {
    if (!_arrData) {
        _arrData = [[NSArray alloc]
                    initWithContentsOfFile:[[NSBundle mainBundle]
                                            pathForResource:@"HomeData"
                                            ofType:@"plist"]];

    }
    return _arrData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
