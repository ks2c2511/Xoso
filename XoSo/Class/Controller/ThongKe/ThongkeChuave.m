//
//  ThongkeChuave.m
//  XoSo
//
//  Created by Khoa Le on 8/5/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeChuave.h"
#import "NSAttributedString+Icon.h"

@interface ThongkeChuave ()
@property (weak, nonatomic) IBOutlet UILabel *testlabel;
@property (weak, nonatomic) IBOutlet UILabel *test2;

@end

@implementation ThongkeChuave

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setText1];
    [self setText2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setText1 {
    NSMutableAttributedString *muAtt = [NSMutableAttributedString new];
    
    NSAttributedString *attSpace = [NSAttributedString atttributeWithText:@" " Font:[UIFont systemFontOfSize:10] Color:[UIColor clearColor]];
    
    for (int i = 0; i < 10 ; i++) {
        if (i!=0) {
             [muAtt appendAttributedString:attSpace];
        }
       
        NSAttributedString *att = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@" %.2d ",i] Font:[UIFont systemFontOfSize:12.0] Color:[UIColor blackColor] BackGroundText:[UIColor greenColor]];
        [muAtt appendAttributedString:att];
        [muAtt appendAttributedString:attSpace];
    }
    
    self.testlabel.attributedText = muAtt;
}

-(void)setText2 {
    NSMutableAttributedString *muAtt = [NSMutableAttributedString new];
    
    NSAttributedString *attSpace = [NSAttributedString atttributeWithText:@" " Font:[UIFont systemFontOfSize:10] Color:[UIColor clearColor]];
    
    for (int i = 11; i < 20 ; i++) {
        if (i!=11) {
            [muAtt appendAttributedString:attSpace];
        }
        
        NSAttributedString *att = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@" %.2d ",i] Font:[UIFont systemFontOfSize:12.0] Color:[UIColor blackColor] BackGroundText:[UIColor greenColor]];
        [muAtt appendAttributedString:att];
        [muAtt appendAttributedString:attSpace];
    }
    
    self.test2.attributedText = muAtt;
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
