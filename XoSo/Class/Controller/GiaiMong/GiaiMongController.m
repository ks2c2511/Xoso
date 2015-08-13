//
//  GiaiMongController.m
//  XoSo
//
//  Created by Khoa Le on 8/13/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "GiaiMongController.h"

#import "Dream.h"
#import <NSManagedObject+GzDatabase.h>
#import "GiaiMongCell.h"

@interface GiaiMongController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *arrData;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contraint_Bottom_Table;

@end

@implementation GiaiMongController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Giải mộng";
    self.imageBackGround.hidden = YES;
    self.tableView.layer.cornerRadius = 4.0;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.masksToBounds = YES;
    
    [self.tableView registerClass:[GiaiMongCell class] forCellReuseIdentifier:NSStringFromClass([GiaiMongCell class])];
    
    [Dream fetchAllWithBlock:^(BOOL succeeded, NSArray *objects) {
        _arrData = objects;
        [self.tableView reloadData];
    }];
    
    
    self.searchBar.enablesReturnKeyAutomatically = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    //For Later Use
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardWasShown:(NSNotification *)notification {
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.contraint_Bottom_Table.constant = keyboardSize.height;
}
- (void)keyboardWillHide:(NSNotification *)notification {
    // Get the size of the keyboard.
    self.contraint_Bottom_Table.constant = 4;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [Dream fetchEntityObjectsWithPredicate:[NSPredicate predicateWithFormat:@"ten CONTAINS[cd] %@",searchText] success:^(BOOL succeeded, NSArray *objects) {
        _arrData = objects;
        [self.tableView reloadData];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GiaiMongCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GiaiMongCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(GiaiMongCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Dream *dream = self.arrData[indexPath.row];
    cell.labelTitle.text = dream.ten;
    cell.labelNumber.text = dream.so;
    
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
