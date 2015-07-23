//
//  ChonCuocController.m
//  XoSo
//
//  Created by Khoa Le on 7/21/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChonCuocController.h"
#import "ChonCuocCell.h"


@interface ChonCuocController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) UIBarButtonItem *buttonDatCuoc;

@end

@implementation ChonCuocController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[ChonCuocCell class] forCellWithReuseIdentifier:NSStringFromClass([ChonCuocCell class])];
    self.imageBackGround.hidden = YES;
    
    self.navigationItem.rightBarButtonItem = self.buttonDatCuoc;
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 100;
    
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChonCuocCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ChonCuocCell class]) forIndexPath:indexPath];
    
    cell.labelNumber.text = [NSString stringWithFormat:@"%2ld",(long)indexPath.row];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UIBarButtonItem *)buttonDatCuoc {
    if (!_buttonDatCuoc) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [btn setTitle:@"Đặt cược" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [
                               UIColor colorWithRed:209.0/255.0 green:51.0/255.0 blue:15.0/255.0 alpha:1.0];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
        [btn addTarget:self action:@selector(DatCuoc) forControlEvents:UIControlEventTouchUpInside];
        _buttonDatCuoc = [[UIBarButtonItem alloc] initWithCustomView:btn];
        btn.layer.cornerRadius = 6.0;
        btn.showsTouchWhenHighlighted = YES;
        btn.layer.masksToBounds = YES;
    }
    return _buttonDatCuoc;
}

-(void)DatCuoc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
