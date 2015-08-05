//
//  XemKQXSStore.m
//  XoSo
//
//  Created by Khoa Le on 7/8/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "XemKQXSStore.h"
#import <LabraryAPI.h>
#import "ConstantDefine.h"
#import <NSManagedObject+GzDatabase.h>
#import "KQXS.h"

@implementation XemKQXSStore
+ (void)GetResultByDateWithDate:(NSString *)date CompanyId:(NSNumber *)companyId Done:(void (^)(BOOL success,NSArray *arrKqsx,NSArray *arrLoto))done {
    
    
    [self getKetquaByDate:[[self dateFormatter] dateFromString:date] CompanyId:[companyId integerValue] Done:^(BOOL success, NSArray *arr) {
        
        NSMutableArray *muArr = [NSMutableArray new];
        for (KQXS *kq in arr) {
            XemKQXSModel *model = [XemKQXSModel new];
            model.RESULT_ID = kq.result_id;
            model.COMPANY_ID = kq.company_id;
            model.PRIZE_ID = kq.price_id;
            model.RESULT_DATE = [[self dateFormatter] stringFromDate:kq.date];
            model.RESULT_NUMBER = kq.result_number;
            model.RESULT_DESC = kq.detail;
            [muArr addObject:model];
        }
        
        if (muArr.count !=0) {
            
            [self makeKQSXAndLoToWithArray:muArr Done:^(BOOL success, NSArray *arrKqsx, NSArray *arrLoto) {
                
                done(success,arrKqsx,arrLoto);
            }];
            
        }
        else {
            NSDictionary *dic = @{@"result_date":date,
                                  @"company_id":companyId};
            
            [[LabraryAPI sharedInstance] GetDataWithClass:[XemKQXSModel class] Url:[BASE_URL stringByAppendingString:GET_XEM_KQXS_THEO_TINH_HIEN_TAI] Parametter:dic JSONKeyPath:nil Callback:^(BOOL success, id objects, id returnData) {
                
                if ([returnData isKindOfClass:[NSArray class]] && returnData != nil) {
                    NSArray *arrData = [MTLJSONAdapter modelsOfClass:[XemKQXSModel class] fromJSONArray:returnData error:nil];
                    [self saveKetquaWithMOdels:arrData];
                    
                    
                    [self makeKQSXAndLoToWithArray:arrData Done:^(BOOL success, NSArray *arrKqsx, NSArray *arrLoto) {
                        done(success,arrKqsx,arrLoto);
                    }];
                }
                else {
                    done(NO,nil,nil);
                }
            }];
        }
        
        
    }];
   
}

+(void)GetResultPreDayWithResultDate:(NSString *)date Ckorder:(NSInteger)index KhoangCachDenNgay:(NSInteger)kc Done:(void (^)(BOOL success,NSArray *arrKqsx,NSArray *arrLoto))done{
    
    NSDictionary *dic = @{@"result_date":date,
                          @"ckorder":@(index),
                          @"scolled":@(kc)};
    
    [[LabraryAPI sharedInstance] GetDataWithClass:[XemKQXSModel class] Url:[BASE_URL stringByAppendingString:GET_XEM_KQXS_PRE_DAY] Parametter:dic JSONKeyPath:nil Callback:^(BOOL success, id objects, id returnData) {
        
        if ([returnData isKindOfClass:[NSArray class]] && returnData != nil) {
            NSArray *arrData = [MTLJSONAdapter modelsOfClass:[XemKQXSModel class] fromJSONArray:returnData error:nil];
            [self saveKetquaWithMOdels:arrData];
            
            
            [self makeKQSXAndLoToWithArray:arrData Done:^(BOOL success, NSArray *arrKqsx, NSArray *arrLoto) {
                done(success,arrKqsx,arrLoto);
            }];
        }
        else {
            done(NO,nil,nil);
        }
    }];
}

+(void)GetResultNearTimeWithMaTinh:(NSNumber *)matinh SoLanQuay:(NSInteger)solanquay Done:(void (^)(BOOL success,NSArray *arrKqsx,NSArray *arrLoto))done {
    
    NSDictionary *dic = @{@"ma_tinh":matinh,
                          @"so_lan_quay":@(solanquay)};
    
    
    [[LabraryAPI sharedInstance] GetDataWithClass:[XemKQXSModel class] Url:[BASE_URL stringByAppendingString:GET_XEM_KQXS_NGAY_GAN_NHAT] Parametter:dic JSONKeyPath:nil Callback:^(BOOL success, id objects, id returnData) {
        
        if ([returnData isKindOfClass:[NSArray class]] && returnData != nil) {
            NSArray *arrData = [MTLJSONAdapter modelsOfClass:[XemKQXSModel class] fromJSONArray:returnData error:nil];
            
            [self saveKetquaWithMOdels:arrData];
            

            [self makeKQSXAndLoToWithArray:arrData Done:^(BOOL success, NSArray *arrKqsx, NSArray *arrLoto) {
                
                done(success,arrKqsx,arrLoto);
            }];

        }
        else {
            done(NO,nil,nil);
        }
    }];
}

+(void)saveKetquaWithMOdels:(NSArray *)models {
    
    for (XemKQXSModel *model in models) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"result_id == %@",model.RESULT_ID];
        
        [KQXS fetchEntityObjectsWithPredicate:pre success:^(BOOL succeeded, NSArray *objects) {
            if (objects.count == 0) {
                KQXS *kq = [KQXS CreateEntityDescription];
                kq.result_id = model.RESULT_ID;
                kq.company_id = model.COMPANY_ID;
                kq.price_id = model.PRIZE_ID;
                kq.date = [[self dateFormatter] dateFromString:model.RESULT_DATE];
                kq.result_number = model.RESULT_NUMBER;
                kq.detail = model.RESULT_DESC;
                [kq saveToPersistentStore];
            }
        }];
       
    }
    
}

+(void)getKetquaByDate:(NSDate *)date CompanyId:(NSInteger)companyId Done:(void(^)(BOOL success,NSArray *arr))done {
     NSPredicate *pre = [NSPredicate predicateWithFormat:@"(date == %@) AND (company_id == %d)",date,companyId];
    

    [KQXS fetchEntityObjectsWithPredicate:pre success:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0) {
             done(succeeded,objects);
        }
        else {
            done(NO,nil);
        }
       
    }];
}


+(void)makeKQSXAndLoToWithArray:(NSArray *)array Done:(void (^)(BOOL success,NSArray *arrKqsx,NSArray *arrLoto))done{
    
    NSMutableArray *arrLoto = [NSMutableArray new];
    
    NSMutableArray *arrKqSubText = [NSMutableArray arrayWithCapacity:array.count];
    for (XemKQXSModel *model in array) {
        if (model.RESULT_NUMBER.length <=2) {
            [arrKqSubText addObject:model.RESULT_NUMBER];
        }
        else {
            [arrKqSubText addObject:[model.RESULT_NUMBER substringFromIndex:model.RESULT_NUMBER.length -2]];
        }
    }
    
    
    if (arrKqSubText.count > 0) {
        for (int i = 0; i<=9; i++) {
            DauDuoiModel *model = [DauDuoiModel new];
            model.gia_tri = i;
            NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",[NSString stringWithFormat:@"%i",i]];
            NSArray *arrfilter = [arrKqSubText filteredArrayUsingPredicate:pre];
            
            for (int k = 0; k < arrfilter.count; k++) {
                NSString *str = [NSString stringWithFormat:@"%@",arrfilter[k]];
                NSRange range = [str rangeOfString:[NSString stringWithFormat:@"%i",i]];
                if ( range.location == NSNotFound) {
                    break;
                }
               
                    if (range.location == 0) {
//                        if (model.duoi && ![[NSString stringWithFormat:@"%@",[str substringFromIndex:1]] isEqualToString:@"0"] && [model.duoi rangeOfString:[str substringFromIndex:1]].location != NSNotFound) {
//                            break;
//                        }
                        
                           model.duoi = (!model.duoi)?[str substringFromIndex:1]: [model.duoi stringByAppendingString:[NSString stringWithFormat:@",%@",[str substringFromIndex:1]]];
                    }
                    else {
                        
//                        if (model.dau && ![[NSString stringWithFormat:@"%@",[str substringToIndex:1]] isEqualToString:@"0"] &&[[str substringToIndex:1] integerValue] !=0 && [model.dau rangeOfString:[str substringToIndex:1]].location != NSNotFound) {
//                            break;
//                        }
                        model.dau = (!model.dau)?[str substringToIndex:1]:[model.dau stringByAppendingString:[NSString stringWithFormat:@",%@",[str substringToIndex:1]]];
                    }
            }
            [arrLoto addObject:model];
        }
    }

    
    
    NSMutableArray *muArrKqsx = [NSMutableArray new];
    for (int i = 0; i <= 7; i++) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"PRIZE_ID == %@",[NSString stringWithFormat:@"%i",i]];
        
        NSArray *termArr = [array filteredArrayUsingPredicate:predicate];
        
        if (termArr.count != 0) {
            NSString *strResult;
            for (int j=0; j< termArr.count; j++) {
                if (j== 0) {
                    strResult = [NSString stringWithFormat:@"%@",[(XemKQXSModel *)termArr[j] RESULT_NUMBER]];
                }
                else {
                    strResult = [strResult stringByAppendingString:[NSString stringWithFormat:@" - %@",[(XemKQXSModel *)termArr[j] RESULT_NUMBER]]];
                }
            }
            
            XemKQXSModel *xemMOdel = (XemKQXSModel *)termArr[0];
            xemMOdel.RESULT_NUMBER = strResult;
            [muArrKqsx addObject:xemMOdel];
            
        }
    }
    
    
    done(YES,muArrKqsx,arrLoto);
}

+(NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateformat;
    if (!dateformat) {
        dateformat = [NSDateFormatter new];
        [dateformat setDateFormat:@"yyyy-MM-dd"];
    }
    return dateformat;
}

@end
