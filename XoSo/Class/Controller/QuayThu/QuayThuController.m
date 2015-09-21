//
//  QuayThuController.m
//  XoSo
//
//  Created by Khoa Le on 8/13/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "QuayThuController.h"

#define RANDOM_INT(__MIN__, __MAX__) ((__MIN__) + arc4random() % ((__MAX__+1) - (__MIN__)))

@interface QuayThuController ()
- (IBAction)Quay:(id)sender;
@property (assign,nonatomic) BOOL isQuay;

@end

@implementation QuayThuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Quay thử XSMB";
    self.imageBackGround.hidden = YES;
    
       // Do any additional setup after loading the view from its nib.
}

-(void)randomNumber {
    if (self.isQuay) {
        
        for (int i = 1; i <= 10; i ++) {
            UILabel *lbl = (UILabel *)[self.view viewWithTag:i];
            lbl.text = [NSString stringWithFormat:@"%d",RANDOM_INT(10000, 99999)];
        }
        for (int i = 11; i <= 20; i++) {
            UILabel *lbl = (UILabel *)[self.view viewWithTag:i];
            lbl.text = [NSString stringWithFormat:@"%d",RANDOM_INT(1000, 9999)];
        }
        for (int i = 21; i <= 23; i++) {
            UILabel *lbl = (UILabel *)[self.view viewWithTag:i];
            lbl.text = [NSString stringWithFormat:@"%d",RANDOM_INT(100, 999)];
        }
        for (int i = 24; i <= 27; i++) {
            UILabel *lbl = (UILabel *)[self.view viewWithTag:i];
            lbl.text = [NSString stringWithFormat:@"%d",RANDOM_INT(10, 99)];
        }
        
        [self performSelector:@selector(randomNumber) withObject:nil afterDelay:.1];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Quay:(id)sender {
    _isQuay = !self.isQuay;
    
     UIButton *btn = sender;
    if (_isQuay) {
       
        [btn setTitle:@"Dừng" forState:UIControlStateNormal];
        [self randomNumber];
    }
    else {
        [btn setTitle:@"Quay" forState:UIControlStateNormal];
    }
}
@end
