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

@implementation XemKQXSStore
+ (void)GetResultByDateWithDate:(NSString *)date CompanyId:(NSNumber *)companyId Done:(void (^)(BOOL success,NSArray *arr))done {
    NSDictionary *dic = @{@"result_date":date,
                          @"company_id":companyId};
    
    [[LabraryAPI sharedInstance] GetDataWithClass:[XemKQXSModel class] Url:[BASE_URL stringByAppendingString:GET_XEM_KQXS_THEO_TINH_HIEN_TAI] Parametter:dic JSONKeyPath:nil Callback:^(BOOL success, id objects, id returnData) {
       
        if ([returnData isKindOfClass:[NSArray class]] && returnData != nil) {
            NSArray *arrData = [MTLJSONAdapter modelsOfClass:[XemKQXSModel class] fromJSONArray:returnData error:nil];
            
            NSMutableArray *muArr = [NSMutableArray new];
            for (int i = 0; i <= 7; i++) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"PRIZE_ID == %@",[NSString stringWithFormat:@"%i",i]];
                
                
                NSArray *termArr = [arrData filteredArrayUsingPredicate:predicate];
                
                
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
                    [muArr addObject:xemMOdel];
                
                }
                
                
                
            }
            done (YES,muArr);
        }
        else {
            done(NO,nil);
        }
    }];
}
@end
