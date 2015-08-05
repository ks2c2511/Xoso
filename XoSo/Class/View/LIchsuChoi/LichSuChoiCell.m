//
//  LichSuChoiCell.m
//  XoSo
//
//  Created by Khoa Le on 7/26/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LichSuChoiCell.h"
#import "NSAttributedString+Icon.h"

@implementation LichSuChoiCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LichSuChoiCell class]) owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTextForCellWithDate:(NSString *)date NameCity:(NSString *)cityName LotoName:(NSString *)lotoName DaySoDatCuoc:(NSString *)sodatcuoc SoXu:(NSString *)soxu Trung:(BOOL)trung ChuaQuaySo:(BOOL)chuaquay{
    
    NSMutableAttributedString *muAtt = [NSMutableAttributedString new];
    if (date && ![date isEqualToString:@""]) {
        NSAttributedString *attDate = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@"%@\n",date] Font:[UIFont systemFontOfSize:14.0] Color:[UIColor grayColor]];
        [muAtt appendAttributedString:attDate];
    }
    if (cityName && ![cityName isEqualToString:@""]) {
        NSAttributedString *attCity = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@"%@\n",cityName] Font:[UIFont boldSystemFontOfSize:14.0] Color:[UIColor blueColor]];
        [muAtt appendAttributedString:attCity];
    }
//    if (cityName && ![cityName isEqualToString:@""]) {
        NSAttributedString *attInfoDatCuoc = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@"%@: %@ - Số xu đặt cược: %@ xu\n",lotoName,sodatcuoc,soxu] Font:[UIFont boldSystemFontOfSize:14.0] Color:[UIColor grayColor]];
        [muAtt appendAttributedString:attInfoDatCuoc];
//    }
    if (chuaquay) {
        NSAttributedString *attTextChuaQuay = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@"%@",@"Chưa có kết quả!"] Font:[UIFont boldSystemFontOfSize:14.0] Color:[UIColor grayColor]];
        [muAtt appendAttributedString:attTextChuaQuay];

    }
    else if (!trung) {
        NSAttributedString *attTextTruot = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@"Trượt rồi! - Số xu bị trừ: %@ xu",soxu] Font:[UIFont boldSystemFontOfSize:14.0] Color:[UIColor redColor]];
        [muAtt appendAttributedString:attTextTruot];
    }
    else {
        NSAttributedString *attTextTrung = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@"Trúng rồi! - Số xu được cộng: %@ xu",soxu] Font:[UIFont boldSystemFontOfSize:14.0] Color:[UIColor blueColor]];
        [muAtt appendAttributedString:attTextTrung];
    }
    
    
    self.labelHistory.attributedText = muAtt;
    muAtt = nil;
}

@end
