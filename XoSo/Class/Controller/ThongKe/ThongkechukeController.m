//
//  ThongkechukeController.m
//  XoSo
//
//  Created by Khoa Le on 8/9/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkechukeController.h"
#import "ThongkechukiCell.h"
#import "ThongkechukiHeader.h"


@interface ThongkechukeController ()
@property (weak, nonatomic) IBOutlet UITextField *textfieldCapso;
@property (weak, nonatomic) IBOutlet UIButton *buttonXemthongke;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ThongkechukeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.buttonXemthongke.layer.borderColor = [UIColor colorWithRed:186.0/255.0 green:163.0/255.0 blue:92.0/255.0 alpha:1.0].CGColor;
    self.buttonXemthongke.layer.borderWidth = 2.0;
    self.buttonXemthongke.layer.cornerRadius = 6.0;
    self.buttonXemthongke.layer.masksToBounds = YES;
    
    self.textfieldCapso.layer.borderColor = [UIColor colorWithRed:186.0/255.0 green:163.0/255.0 blue:92.0/255.0 alpha:1.0].CGColor;
    self.textfieldCapso.layer.borderWidth = 2.0;
    self.textfieldCapso.layer.cornerRadius = 6.0;
    self.textfieldCapso.layer.masksToBounds = YES;
    
    self.buttonCity.layer.cornerRadius = 6.0;
    self.buttonCity.layer.masksToBounds = YES;
    
    self.imageBackGround.hidden = YES
    ;
    
    [self.tableView registerClass:[ThongkechukiCell class] forCellReuseIdentifier:NSStringFromClass([ThongkechukiCell class])];
    [self.tableView registerClass:[ThongkechukiHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ThongkechukiHeader class])];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ThongkechukiHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ThongkechukiHeader class])];
    if (!header) {
        header = [[ThongkechukiHeader alloc] initWithReuseIdentifier:NSStringFromClass([ThongkechukiHeader class])];
    }
    header.contentView.backgroundColor = [UIColor whiteColor];
    
       return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThongkechukiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThongkechukiCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(ThongkechukiCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIColor *color;
    if (indexPath.row %2 == 0) {
        color = [UIColor colorWithRed:237.0/255.0 green:227.0/255.0 blue:197.0/255.0 alpha:1.0];
    }
    else {
        color = [UIColor colorWithRed:242.0/255.0 green:218.0/255.0 blue:144.0/255.0 alpha:1.0];
    }
    
    cell.labelChuki.backgroundColor = color;
    cell.labelNgay.backgroundColor = color;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
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

@end
