//
//  LoToDatCuocController.m
//  XoSo
//
//  Created by Khoa Le on 7/20/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "LoToDatCuocController.h"
#import "ChonCuocController.h"
#import "CustomSegment.h"
#import "ButtonBorder.h"
#import "ChontinhCell.h"

@interface LoToDatCuocController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LoToDatCuocController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ChontinhCell class] forCellReuseIdentifier:NSStringFromClass([ChontinhCell class])];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChontinhCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChontinhCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(ChontinhCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (IBAction)SelectSecment:(CustomSegment *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        
    }
    else if (sender.selectedSegmentIndex == 1) {
        
    }
    else {
        
    }
}

- (IBAction)SelectLoaiSoXo:(ButtonBorder *)sender {
    
    ChonCuocController *choncuoc = [ChonCuocController new];
    [self.navigationController pushViewController:choncuoc animated:YES];
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
