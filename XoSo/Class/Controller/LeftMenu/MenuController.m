//
//  MenuController.m
//  XoSo
//
//  Created by Khoa Le on 7/4/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "MenuController.h"
#import "ConstantDefine.h"
#import "NSAttributedString+Icon.h"
#import "UIColor+AppTheme.h"
#import "User.h"
#import <NSManagedObject+GzDatabase.h>

@interface MenuController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contraint_W_Table;
@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;
@property (weak, nonatomic) IBOutlet UILabel *labelInfoProfile;

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contraint_W_Table.constant = [[UIScreen mainScreen] bounds].size.width/ratioMenuAndMainView;
    
    [User fetchAllWithBlock:^(BOOL succeeded, NSArray *objects) {
        if (objects.count != 0) {
            User *use = [objects firstObject];
            self.labelInfoProfile.attributedText = [self attWithName:use.user_name Email:use.email SurPlus:[use.point integerValue]];
            
        }
    }];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(NSAttributedString *)attWithName:(NSString *)name Email:(NSString *)email SurPlus:(NSInteger)surplus {
    NSMutableAttributedString *muAtt = [NSMutableAttributedString new];
    NSAttributedString *attName = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@"%@\n",name] Font:[UIFont boldSystemFontOfSize:12] Color:[UIColor whiteColor]];
    [muAtt appendAttributedString:attName];
    
    if (!(email == nil || [email isEqualToString:@""])) {
        NSAttributedString *attEmail = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@"%@\n",email] Font:[UIFont italicSystemFontOfSize:12] Color:[UIColor whiteColor]];
        [muAtt appendAttributedString:attEmail];
    }
    
        NSAttributedString *attSurPlus = [NSAttributedString atttributeWithText:[NSString stringWithFormat:@"Số dư %ld xu",(long)surplus] Font:[UIFont italicSystemFontOfSize:12] Color:[UIColor whiteColor]];
        [muAtt appendAttributedString:attSurPlus];
    
    return muAtt;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
