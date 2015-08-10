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

#import <NSManagedObject+GzDatabase.h>


@implementation TuongthuatStore
+ (void)getTuongThuatTrucTiepWithMaMien:(NSInteger)mamien Done:(void (^)(BOOL success,NSArray *arr))done {
    
    NSDictionary *dic = @{@"ma_mien": @(mamien)};
    
    [[GzNetworking sharedInstance] GET:[BASE_URL stringByAppendingString:GET_TUONGTHUAT_TRUCTIEP] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject &&[responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[TuongthuatModel class] fromJSONArray:responseObject error:nil];
            
            if (mamien == 1) {
                [self makeKQSXAndLoToMienBacWithArray:arr Done:^(BOOL success, NSArray *arrKqsx) {
                    done(YES,arrKqsx);
                }];
            }
            else if (mamien == 2) {
                [self makeKQSXAndLoToMienTrungWithArray:arr Done:^(BOOL success, NSArray *arrKqsx) {
                    done(YES,arrKqsx);
                }];
            }
            else {
                [self makeKQSXAndLoToMienNamWithArray:arr Done:^(BOOL success, NSArray *arrKqsx) {
                    done(YES,arrKqsx);
                }];
            }
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            done(NO,nil);
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

+(void)makeKQSXAndLoToMienTrungWithArray:(NSArray *)array Done:(void (^)(BOOL success,NSArray *arrKqsx))done{
    
//    @autoreleasepool {
        NSMutableArray *muArrKqsx = [NSMutableArray new];
        
        NSMutableArray *muArrProvince = [NSMutableArray new];
    int maxmagiai = 0;
    int minmagiai = 10;
        for (TuongthuatModel *mod in array) {
            NSPredicate *preProvince = [NSPredicate predicateWithFormat:@"province_id == %@",mod.ma_tinh];
            NSArray *results = [Province fetchEntityObjectsWithPredicate:preProvince];
            if (results.count != 0) {
                [muArrProvince addObject:[results firstObject]];
            }
            if ([mod.ma_giai integerValue] > maxmagiai) {
                maxmagiai = [mod.ma_giai intValue];
            }
            
            if ([mod.ma_giai integerValue] < minmagiai) {
                minmagiai = [mod.ma_giai intValue];
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
    else if (arrRemoveDuplicate.count >= 3) {
        modelTenTinh.ma_giai = @"G";
        modelTenTinh.arr = @[arrRemoveDuplicate[0]];
        modelTenTinh.arr1 = @[arrRemoveDuplicate[1]];
        modelTenTinh.arr2 = @[arrRemoveDuplicate[2]];
        [muArrKqsx addObject:modelTenTinh];

    }
    
        for (int i = maxmagiai; i >= minmagiai; i--) {
           
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ma_giai == %@",[NSString stringWithFormat:@"%i",i]];
            
            NSArray *termArr = [array filteredArrayUsingPredicate:predicate];
            
            NSMutableArray *termArr0 = [NSMutableArray new];
            NSMutableArray *termArr1 = [NSMutableArray new];
            NSMutableArray *termArr2 = [NSMutableArray new];
            
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
                    }
                }
                
            }
            
            TuongthuatConvertModel *model = [TuongthuatConvertModel new];
            model.arr = termArr0;
            model.arr1 = termArr1;
            model.arr2 = termArr2;
            model.ma_giai = [NSString stringWithFormat:@"%i",i];
            
            [muArrKqsx addObject:model];
        }
        
        done(YES,muArrKqsx);
    
    
    
}

+(void)makeKQSXAndLoToMienNamWithArray:(NSArray *)array Done:(void (^)(BOOL success,NSArray *arrKqsx))done{
    
    //    @autoreleasepool {
    NSMutableArray *muArrKqsx = [NSMutableArray new];
    
    NSMutableArray *muArrProvince = [NSMutableArray new];
    int maxmagiai = 0;
    int minmagiai = 10;
    for (TuongthuatModel *mod in array) {
        NSPredicate *preProvince = [NSPredicate predicateWithFormat:@"province_id == %@",mod.ma_tinh];
        NSArray *results = [Province fetchEntityObjectsWithPredicate:preProvince];
        if (results.count != 0) {
            [muArrProvince addObject:[results firstObject]];
        }
        if ([mod.ma_giai integerValue] > maxmagiai) {
            maxmagiai = [mod.ma_giai intValue];
        }
        
        if ([mod.ma_giai integerValue] < minmagiai) {
            minmagiai = [mod.ma_giai intValue];
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
    else if (arrRemoveDuplicate.count >= 3) {
        modelTenTinh.ma_giai = @"G";
        modelTenTinh.arr = @[arrRemoveDuplicate[0]];
        modelTenTinh.arr1 = @[arrRemoveDuplicate[1]];
        modelTenTinh.arr2 = @[arrRemoveDuplicate[2]];
        [muArrKqsx addObject:modelTenTinh];
        
    }
    
    for (int i = maxmagiai; i >= minmagiai; i--) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ma_giai == %@",[NSString stringWithFormat:@"%i",i]];
        
        NSArray *termArr = [array filteredArrayUsingPredicate:predicate];
        
        NSMutableArray *termArr0 = [NSMutableArray new];
        NSMutableArray *termArr1 = [NSMutableArray new];
        NSMutableArray *termArr2 = [NSMutableArray new];
        
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
                }
            }
            
        }
        
        TuongthuatConvertModel *model = [TuongthuatConvertModel new];
        model.arr = termArr0;
        model.arr1 = termArr1;
        model.arr2 = termArr2;
        model.ma_giai = [NSString stringWithFormat:@"%i",i];
        
        [muArrKqsx addObject:model];
    }
    if (muArrKqsx.count != 1) {
        [muArrKqsx addObject:muArrKqsx[1]];
        [muArrKqsx removeObjectAtIndex:1];
    }
   
    
    done(YES,muArrKqsx);
    
    
    
}

@end
