//
//  TuongthuatStore.m
//  XoSo
//
//  Created by Khoa Le on 8/6/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "TuongthuatStore.h"
#import "ConstantDefine.h"
#import <GzNetworking.h>
#import "Lotery.h"
#import <NSManagedObject+GzDatabase.h>
#import "CalendarData.h"

@implementation TuongthuatStore
+ (void)getTuongThuatTrucTiepWithMaMien:(NSInteger)mamien Done:(void (^)(BOOL success,NSArray *arr,NSInteger numberProvince))done {
    
    NSDictionary *dic = @{@"ma_mien": @(mamien)};
   
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_TUONGTHUAT_TRUCTIEP] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject &&[responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[TuongthuatModel class] fromJSONArray:responseObject error:nil];
            
        
            if (mamien == 1) {
                [self makeKQSXAndLoToMienBacWithArray:arr Done:^(BOOL success, NSArray *arrKqsx) {
                    done(YES,arrKqsx,1);
                }];
            }
            else if (mamien == 2) {
                [self makeKQSXAndLoToMienTrungWithArray:arr Done:^(BOOL success, NSArray *arrKqsx,NSInteger numberProvince) {
                    done(YES,arrKqsx,numberProvince);
                }];
            }
            else {
                [self makeKQSXAndLoToMienNamWithArray:arr Done:^(BOOL success, NSArray *arrKqsx,NSInteger numberProvince) {
                    done(YES,arrKqsx,numberProvince);
                }];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            if (mamien == 1) {
                [self makeKQSXAndLoToMienBacWithArray:nil Done:^(BOOL success, NSArray *arrKqsx) {
                    done(YES,arrKqsx,1);
                }];
            }
            else if (mamien == 2) {
                [self makeKQSXAndLoToMienTrungWithArray:nil Done:^(BOOL success, NSArray *arrKqsx,NSInteger numberProvince) {
                    done(YES,arrKqsx,numberProvince);
                }];
            }
            else {
                [self makeKQSXAndLoToMienNamWithArray:nil Done:^(BOOL success, NSArray *arrKqsx,NSInteger numberProvince) {
                    done(YES,arrKqsx,numberProvince);
                }];
        }
    }
    }];
}

+(void)makeKQSXAndLoToMienBacWithArray:(NSArray *)array Done:(void (^)(BOOL success,NSArray *arrKqsx))done{
    
    NSMutableArray *muArrKqsx = [NSMutableArray new];
    for (int i = 0; i <= 7; i++) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ma_giai == %@",[NSString stringWithFormat:@"%i",i]];
        
        NSArray *termArr = [array filteredArrayUsingPredicate:predicate];
        
        TuongthuatConvertModel *model = [TuongthuatConvertModel new];
        model.arr = termArr;
        model.ma_giai = [NSString stringWithFormat:@"%i",i];
        
        [muArrKqsx addObject:model];
    }
    
    done(YES,muArrKqsx);
}

+(void)makeKQSXAndLoToMienTrungWithArray:(NSArray *)array Done:(void (^)(BOOL success,NSArray *arrKqsx,NSInteger numberProvince))done{
    
    
    [self getprovinceHasLoteryWithDay:[CalendarData getCurrentDayOfWeek] Done:^(BOOL success, NSArray *arr) {
        
        NSMutableArray *muArrKqsx = [NSMutableArray new];
        
        NSMutableArray *muArrProvince = [NSMutableArray new];
        int maxmagiai = 9;
        int minmagiai = 0;
        for (Lotery *mod in arr) {
            NSPredicate *preProvince = [NSPredicate predicateWithFormat:@"province_id == %@ AND province_group == %@",[NSString stringWithFormat:@"%@",mod.company_id], [NSString stringWithFormat:@"%i",2]];
            NSArray *results = [Province fetchEntityObjectsWithPredicate:preProvince];
            
            if (results.count != 0) {
                [muArrProvince addObject:[results firstObject]];
            }
        }
        
        TuongthuatConvertModel *modelTenTinh = [TuongthuatConvertModel new];
        NSArray *arrRemoveDuplicate = [[NSSet setWithArray: muArrProvince] allObjects];
        if (arrRemoveDuplicate.count ==2) {
            modelTenTinh.ma_giai = @"G";
            modelTenTinh.arr = @[arrRemoveDuplicate[0]];
            modelTenTinh.arr1 = @[arrRemoveDuplicate[1]];
            [muArrKqsx addObject:modelTenTinh];
        }
        else if (arrRemoveDuplicate.count == 3) {
            modelTenTinh.ma_giai = @"G";
            modelTenTinh.arr = @[arrRemoveDuplicate[0]];
            modelTenTinh.arr1 = @[arrRemoveDuplicate[1]];
            modelTenTinh.arr2 = @[arrRemoveDuplicate[2]];
            [muArrKqsx addObject:modelTenTinh];
        }
        else if (arrRemoveDuplicate.count == 4) {
            modelTenTinh.ma_giai = @"G";
            modelTenTinh.arr = @[arrRemoveDuplicate[0]];
            modelTenTinh.arr1 = @[arrRemoveDuplicate[1]];
            modelTenTinh.arr2 = @[arrRemoveDuplicate[2]];
            modelTenTinh.arr3 = @[arrRemoveDuplicate[3]];
            [muArrKqsx addObject:modelTenTinh];
        }
        
        for (int i = 8; i >= minmagiai; i--) {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ma_giai == %@",[NSString stringWithFormat:@"%i",i]];
            
//            Lấy tất cả kết quả của 1 giải
            NSArray *termArr = [array filteredArrayUsingPredicate:predicate];
            
//            4 aray chứa mã giải của các tỉnh tương ứng
            NSMutableArray *termArr0 = [NSMutableArray new];
            NSMutableArray *termArr1 = [NSMutableArray new];
            NSMutableArray *termArr2 = [NSMutableArray new];
            NSMutableArray *termArr3 = [NSMutableArray new];
            if (termArr.count == 0) {
                for (int k = 0; k<arrRemoveDuplicate.count; k++) {
                    TuongthuatModel *md = [TuongthuatModel new];
                    md.ma_giai = [NSString stringWithFormat:@"%i",i];
                    md.ma_tinh = [NSString stringWithFormat:@"%i",k];
                    md.idTuongthuat = @"";
                    
                    if (i == 6) {
                        md.ket_qua = [self numLineDotWithValue:3];
                    }
                    else if (i == 4) {
                        md.ket_qua = [self numLineDotWithValue:7];
                    }
                    else if (i == 3) {
                        md.ket_qua = [self numLineDotWithValue:2];
                    }
                    else {
                        md.ket_qua = [self numLineDotWithValue:1];
                    }
                    
                    if (k == 0) {
                        [termArr0 addObject:md];
                    }
                    else if (k == 1) {
                        [termArr1 addObject:md];
                    }
                    else if (k == 2) {
                        [termArr2 addObject:md];
                    }
                    else if (k == 3) {
                        [termArr3 addObject:md];
                    }
                    
                }
            }
            else {
                for (TuongthuatModel *moFilter in termArr) {
                    
                    for (int k = 0; k<arrRemoveDuplicate.count; k++) {
                        if ([moFilter.ma_tinh isEqualToString:[[arrRemoveDuplicate[k] province_id] stringValue]]) {
                            if (k == 0) {
                                [termArr0 addObject:moFilter];
                            }
                            else if (k == 1) {
                                [termArr1 addObject:moFilter];
                            }
                            else if (k == 2) {
                                [termArr2 addObject:moFilter];
                            }
                            else if (k == 3) {
                                [termArr3 addObject:moFilter];
                            }
                        }
                    }
                    
                }
                
                if (i == 6) {
                    if (termArr0.count < 3 ) {
                        for (int j = (int)termArr0.count; j < 3; j++) {
                            [termArr0 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr1.count < 3 ) {
                        for (int j = (int)termArr1.count; j < 3; j++) {
                            [termArr1 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr2.count < 3 ) {
                        for (int j = (int)termArr2.count; j < 3; j++) {
                            [termArr2 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr3.count < 3 ) {
                        for (int j = (int)termArr3.count; j < 3; j++) {
                            [termArr3 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                }
                else if (i == 4) {
                    if (termArr0.count < 7 ) {
                        for (int j = (int)termArr0.count; j < 7; j++) {
                            [termArr0 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr1.count < 7 ) {
                        for (int j = (int)termArr1.count; j < 7; j++) {
                            [termArr1 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr2.count < 7 ) {
                        for (int j = (int)termArr2.count; j < 7; j++) {
                            [termArr2 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr3.count < 7 ) {
                        for (int j = (int)termArr3.count; j < 7; j++) {
                            [termArr3 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                }
                else if (i == 3) {
                    if (termArr0.count < 2 ) {
                        for (int j = (int)termArr0.count; j < 2; j++) {
                            [termArr0 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr1.count < 2 ) {
                        for (int j = (int)termArr1.count; j < 2; j++) {
                            [termArr1 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr2.count < 2 ) {
                        for (int j = (int)termArr2.count; j < 2; j++) {
                            [termArr2 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr3.count < 2 ) {
                        for (int j = (int)termArr3.count; j < 2; j++) {
                            [termArr3 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                }
            }
            
            TuongthuatConvertModel *model = [TuongthuatConvertModel new];
            
            
           
            model.arr = termArr0;
            model.arr1 = termArr1;
            model.arr2 = termArr2;
            model.arr3 = termArr3;
            model.ma_giai = [NSString stringWithFormat:@"%i",i];
            
            [muArrKqsx addObject:model];
        }
        
        done(YES,muArrKqsx,arrRemoveDuplicate.count);

    }];
    
}

+(void)makeKQSXAndLoToMienNamWithArray:(NSArray *)array Done:(void (^)(BOOL success,NSArray *arrKqsx,NSInteger numberProvince))done{
    
    [self getprovinceHasLoteryWithDay:[CalendarData getCurrentDayOfWeek] Done:^(BOOL success, NSArray *arr) {
        //    @autoreleasepool {
        NSMutableArray *muArrKqsx = [NSMutableArray new];
        
        NSMutableArray *muArrProvince = [NSMutableArray new];
        int maxmagiai = 10;
        int minmagiai = 1;
        
        for (Lotery *mod in arr) {
            NSPredicate *preProvince = [NSPredicate predicateWithFormat:@"province_id == %@ AND province_group == %@",[NSString stringWithFormat:@"%@",mod.company_id], [NSString stringWithFormat:@"%i",3]];
            NSArray *results = [Province fetchEntityObjectsWithPredicate:preProvince];
            
            if (results.count != 0) {
                [muArrProvince addObject:[results firstObject]];
            }
        }
        
        TuongthuatConvertModel *modelTenTinh = [TuongthuatConvertModel new];
        NSArray *arrRemoveDuplicate = [[NSSet setWithArray: muArrProvince] allObjects];
        if (arrRemoveDuplicate.count ==2) {
            modelTenTinh.ma_giai = @"G";
            modelTenTinh.arr = @[arrRemoveDuplicate[0]];
            modelTenTinh.arr1 = @[arrRemoveDuplicate[1]];
            [muArrKqsx addObject:modelTenTinh];
        }
        else if (arrRemoveDuplicate.count == 3) {
            modelTenTinh.ma_giai = @"G";
            modelTenTinh.arr = @[arrRemoveDuplicate[0]];
            modelTenTinh.arr1 = @[arrRemoveDuplicate[1]];
            modelTenTinh.arr2 = @[arrRemoveDuplicate[2]];
            [muArrKqsx addObject:modelTenTinh];
        }
        else if (arrRemoveDuplicate.count == 4) {
            modelTenTinh.ma_giai = @"G";
            modelTenTinh.arr = @[arrRemoveDuplicate[0]];
            modelTenTinh.arr1 = @[arrRemoveDuplicate[1]];
            modelTenTinh.arr2 = @[arrRemoveDuplicate[2]];
            modelTenTinh.arr3 = @[arrRemoveDuplicate[3]];
            [muArrKqsx addObject:modelTenTinh];
        }
        
        for (int i = 9; i >= minmagiai; i--) {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ma_giai == %@",[NSString stringWithFormat:@"%i",i]];
            NSArray *termArr = [array filteredArrayUsingPredicate:predicate];
            
            NSMutableArray *termArr0 = [NSMutableArray new];
            NSMutableArray *termArr1 = [NSMutableArray new];
            NSMutableArray *termArr2 = [NSMutableArray new];
            NSMutableArray *termArr3 = [NSMutableArray new];
            
            if (termArr.count == 0) {
                for (int k = 0; k<arrRemoveDuplicate.count; k++) {
                    TuongthuatModel *md = [TuongthuatModel new];
                    md.ma_giai = [NSString stringWithFormat:@"%i",i];
                    md.ma_tinh = [NSString stringWithFormat:@"%i",k];
                    md.idTuongthuat = @"";
                    if (i == 6) {
                        md.ket_qua = [self numLineDotWithValue:3];
                    }
                    else if (i == 4) {
                        md.ket_qua = [self numLineDotWithValue:7];
                    }
                    else if (i == 3) {
                        md.ket_qua = [self numLineDotWithValue:2];
                    }
                    else {
                        md.ket_qua = [self numLineDotWithValue:1];
                    }
                    if (k == 0) {
                        [termArr0 addObject:md];
                    }
                    else if (k == 1) {
                        [termArr1 addObject:md];
                    }
                    else if (k == 2) {
                        [termArr2 addObject:md];
                    }
                    else if (k == 3) {
                        [termArr3 addObject:md];
                    }
                }
            }
            else {
                for (TuongthuatModel *moFilter in termArr) {
                    
                    for (int k = 0; k<arrRemoveDuplicate.count; k++) {
                        if ([moFilter.ma_tinh isEqualToString:[[arrRemoveDuplicate[k] province_id] stringValue]]) {
                            if (k == 0) {
                                [termArr0 addObject:moFilter];
                            }
                            else if (k == 1) {
                                [termArr1 addObject:moFilter];
                            }
                            else if (k == 2) {
                                [termArr2 addObject:moFilter];
                            }
                            else if (k == 3) {
                                [termArr3 addObject:moFilter];
                            }
                        }
                    }
                }
                
                if (i == 6) {
                    if (termArr0.count < 3 ) {
                        for (int j = (int)termArr0.count; j < 3; j++) {
                            [termArr0 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr1.count < 3 ) {
                        for (int j = (int)termArr1.count; j < 3; j++) {
                            [termArr1 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr2.count < 3 ) {
                        for (int j = (int)termArr2.count; j < 3; j++) {
                            [termArr2 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr3.count < 3 ) {
                        for (int j = (int)termArr3.count; j < 3; j++) {
                            [termArr3 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                }
                else if (i == 4) {
                    if (termArr0.count < 7 ) {
                        for (int j = (int)termArr0.count; j < 7; j++) {
                            [termArr0 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr1.count < 7 ) {
                        for (int j = (int)termArr1.count; j < 7; j++) {
                            [termArr1 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr2.count < 7 ) {
                        for (int j = (int)termArr2.count; j < 7; j++) {
                            [termArr2 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr3.count < 7 ) {
                        for (int j = (int)termArr3.count; j < 7; j++) {
                            [termArr3 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                }
                else if (i == 3) {
                    if (termArr0.count < 2 ) {
                        for (int j = (int)termArr0.count; j < 2; j++) {
                            [termArr0 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr1.count < 2 ) {
                        for (int j = (int)termArr1.count; j < 2; j++) {
                            [termArr1 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr2.count < 2 ) {
                        for (int j = (int)termArr2.count; j < 2; j++) {
                            [termArr2 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                    if (termArr3.count < 2 ) {
                        for (int j = (int)termArr3.count; j < 2; j++) {
                            [termArr3 addObject:[self createNewModelWithMaTinh:@"" MaMien:@"" Magiai:@""]];
                        }
                    }
                }
            }
            
            
            TuongthuatConvertModel *model = [TuongthuatConvertModel new];
            model.arr = termArr0;
            model.arr1 = termArr1;
            model.arr2 = termArr2;
            model.arr3 = termArr3;
            model.ma_giai = [NSString stringWithFormat:@"%i",i];
            [muArrKqsx addObject:model];
        }
        if (muArrKqsx.count != 1) {
            [muArrKqsx addObject:muArrKqsx[1]];
            [muArrKqsx removeObjectAtIndex:1];
        }
        done(YES,muArrKqsx,arrRemoveDuplicate.count);
    }];
   
}

+(void)getprovinceHasLoteryWithDay:(NSInteger)day Done:(void (^)(BOOL success, NSArray *arr))done {

    
    [Lotery fetchEntityObjectsWithPredicate:[NSPredicate predicateWithFormat:@"day_id == %@",[NSString stringWithFormat:@"%ld",(long)day]] success:^(BOOL succeeded, NSArray *objects) {
        if (succeeded) {
            done(YES,objects);
            
        }
        else {
            done(NO,nil);
        }
    }];
    
}

+(NSString *)numLineDotWithValue:(NSInteger)value {
     if (value == 0) {
        return @"";
    }
     else if (value == 1) {
         return @"...";
     }
    
     else if (value == 2) {
         return @"...\n...";
     }
    else {
        NSString *dot = @"";
        for (int i = 1; i <= value; i ++) {
            dot = [dot stringByAppendingString:@"...\n"];
        }
        return dot;
    }
}

+(TuongthuatModel *)createNewModelWithMaTinh:(NSString *)matinh MaMien:(NSString *)mamien Magiai:(NSString *)magiai {
    TuongthuatModel *tt = [TuongthuatModel new];
    tt.idTuongthuat = @"";
    tt.ma_giai = magiai;
    tt.ma_mien = mamien;
    tt.ma_tinh = matinh;
    tt.ket_qua = @"...";
    
    return tt;
}

@end
