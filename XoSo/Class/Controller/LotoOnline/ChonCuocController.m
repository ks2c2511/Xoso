//
//  ChonCuocController.m
//  XoSo
//
//  Created by Khoa Le on 7/21/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChonCuocController.h"
#import "ChonCuocCell.h"
#import "CustomTextField.h"
#import <NSManagedObject+GzDatabase.h>
#import "User.h"
#import <UIAlertView+Blocks.h>
#import "LotoOnlineStore.h"
#import "NSString+FromArray.h"
#import "LichSuCuocController.h"
@interface ChonCuocController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) UIBarButtonItem *buttonDatCuoc;
@property (strong,nonatomic) NSMutableArray *arrChonSo;
@property (weak, nonatomic) IBOutlet UIView *contentPopupView;
@property (weak, nonatomic) IBOutlet UILabel *labelSodu;
@property (weak, nonatomic) IBOutlet CustomTextField *textfieldNhapSo;
@property (weak, nonatomic) IBOutlet UILabel *labelInfo;
- (IBAction)ChapNhan:(id)sender;
- (IBAction)Huy:(id)sender;
- (IBAction)ChangeNumber:(CustomTextField *)sender;

@property (weak, nonatomic) IBOutlet UIView *popupView;
@end

@implementation ChonCuocController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Lô tô online";
    
    self.popupView.alpha = 0;
    [self.collectionView registerClass:[ChonCuocCell class] forCellWithReuseIdentifier:NSStringFromClass([ChonCuocCell class])];
    self.imageBackGround.hidden = YES;
    
    
    self.arrChonSo = [NSMutableArray arrayWithCapacity:self.loto.numbersocuoc];
    
    [User fetchAllWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0) {
            User *user = [objects firstObject];
            self.labelSodu.text = [NSString stringWithFormat:@"Số dư: %@",user.point];
        }
    }];
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
    
    cell.labelNumber.text = [NSString stringWithFormat:@"%.2ld",(long)indexPath.row];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF == %@",@(indexPath.row)];
    NSArray *arrFilter = [self.arrChonSo filteredArrayUsingPredicate:pre];
    if (arrFilter.count != 0) {
        cell.labelNumber.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:102.0/255.0 blue:12.0/255.0 alpha:1.0];
        
    }
    else {
        cell.labelNumber.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.arrChonSo.count <= self.loto.numbersocuoc) {
        
        
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF == %@",@(indexPath.row)];
        NSArray *arrFilter = [self.arrChonSo filteredArrayUsingPredicate:pre];
        if (arrFilter.count != 0) {
            [self.arrChonSo removeObjectsInArray:arrFilter];
            
        }
        else {
            if (self.arrChonSo.count < self.loto.numbersocuoc) {
                [self.arrChonSo addObject:@(indexPath.row)];
            }
            
        }
        
        if (self.arrChonSo.count ==  self.loto.numbersocuoc) {
            self.navigationItem.rightBarButtonItem = self.buttonDatCuoc;
        }
        else {
            self.navigationItem.rightBarButtonItem = [UIBarButtonItem new];
        }
        
        [self.collectionView reloadData];
    }
    
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
    self.loto.arrCuoc = self.arrChonSo;
    self.popupView.alpha =1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ChapNhan:(id)sender {
   
    
    
    [self.textfieldNhapSo resignFirstResponder];
    
    if ([self.textfieldNhapSo.text isEqualToString:@""]) {
        UIAlertView *alert = [UIAlertView showWithTitle:@"Thông báo" message:@"Bạn cần nhập số xu." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
        [alert show];
    }
    else {
        self.popupView.alpha = 0;
        self.loto.soxu = [self.textfieldNhapSo.text integerValue];
        
      
        
        [LotoOnlineStore postLotoWithDate:self.loto.date LotoTypeId:self.loto.lotoTypeId LotoNumber:[NSString stringFromArray:self.loto.arrCuoc] PointDatCuoc:self.loto.soxu Done:^(BOOL success, id data) {
            if (success) {
                LichSuCuocController *lichsu = [LichSuCuocController new];
                lichsu.showFutureCuoc = YES;
                [self.navigationController pushViewController:lichsu animated:YES];
            }
            else {
                [UIAlertView showWithTitle:@"Thất bại" message:@"Đặt cược thất bại. Vui lòng thử lại." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:Nil];
            }
        }];
        
    }
}

- (IBAction)Huy:(id)sender {
    
    self.popupView.alpha =0;
    [self.textfieldNhapSo resignFirstResponder];
   
}

- (IBAction)ChangeNumber:(CustomTextField *)sender {
    
    if ([sender.text isEqualToString:@""]) {
        self.labelInfo.text = @"";
    }
    else {
        self.labelInfo.text = [NSString stringWithFormat:@"Tổng: %@: %ld",self.loto.lotoTypeName,[sender.text integerValue]*self.loto.unit];
    }
}
@end
