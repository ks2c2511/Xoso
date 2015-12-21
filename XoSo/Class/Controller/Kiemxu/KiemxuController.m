//
//  KiemxuController.m
//  XoSo
//
//  Created by Khoa Le on 7/22/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "KiemxuController.h"
#import "User.h"
#import <NSManagedObject+GzDatabase.h>
#import "NapquaSMS.h"
#import "TheCaoController.h"

@interface KiemxuController ()
@property (weak, nonatomic) IBOutlet UILabel *labelSoXu;
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;
@property (strong,nonatomic) NSString *userId;
- (IBAction)CaiUngDung:(id)sender;
- (IBAction)NapTheCao:(id)sender;

@end

@implementation KiemxuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Nạp xu";
    
    
    self.viewBackGround.layer.borderColor = [UIColor colorWithRed:70.0/255.0 green:35.0/255.0 blue:4.0/255.0 alpha:1.0].CGColor;
    self.viewBackGround.layer.borderWidth = 6.0;
    self.viewBackGround.layer.cornerRadius = 6.0;
    
    
    [User fetchAllWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0) {
            User *user = [objects firstObject];
            self.labelSoXu.text = [NSString stringWithFormat:@"Số xu trong tài khoản của bạn là: %@ xu",user.point];
            self.userId = user.user_id;
        }
    }];

    // Do any additional setup after loading the view from its nib.
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

- (IBAction)CaiUngDung:(id)sender {
    
    NapquaSMS *sms = [NapquaSMS new];
    sms.userId = self.userId;
    [self.navigationController pushViewController:sms animated:YES];
    
}

- (IBAction)NapTheCao:(id)sender {
    TheCaoController *thecao = [TheCaoController new];
    thecao.userId = self.userId;
    [self.navigationController pushViewController:thecao animated:YES];
    
}
@end
