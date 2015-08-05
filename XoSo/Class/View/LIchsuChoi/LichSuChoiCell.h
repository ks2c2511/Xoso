//
//  LichSuChoiCell.h
//  XoSo
//
//  Created by Khoa Le on 7/26/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LichSuChoiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelHistory;

-(void)setTextForCellWithDate:(NSString *)date NameCity:(NSString *)cityName LotoName:(NSString *)lotoName DaySoDatCuoc:(NSString *)sodatcuoc SoXu:(NSString *)soxu Trung:(BOOL)trung ChuaQuaySo:(BOOL)chuaquay;
@end
