//
//  ChatLevelTwoController.m
//  XoSo
//
//  Created by Khoa Le on 8/15/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChatLevelTwoController.h"
#import "ChatStore.h"
#import "ChatMasterCell.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
#import <UIAlertView+Blocks.h>

@interface ChatLevelTwoController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (strong,nonatomic) NSArray *arrData;
@property (assign,nonatomic) NSInteger currentPage;
@property (assign,nonatomic) BOOL isLIked;
- (IBAction)BinhLuan:(id)sender;

@end

@implementation ChatLevelTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Phòng chat";
    
    _currentPage = 1;
    [self.tableView registerClass:[ChatMasterCell class] forCellReuseIdentifier:NSStringFromClass([ChatMasterCell class])];
    self.tableView.tableFooterView = [UIView new];
    
    [ChatStore getChatLevelTwoWithPage:self.currentPage ObjectId:self.object_id Done:^(BOOL success, NSArray *arr) {
        if (success) {
            self.arrData = arr;
            [self.tableView reloadData];
        }
    }];
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.triggerVerticalOffset = 10;
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.attributedTitle = [[NSAttributedString alloc]
                                      initWithString:@"Load more..."
                                      attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    [refreshControl addTarget:self
                       action:@selector(refresh:)
             forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl = refreshControl;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)refresh:(UIRefreshControl *)ref {
    self.currentPage += 1;
    [ChatStore getChatLevelTwoWithPage:self.currentPage ObjectId:self.object_id Done:^(BOOL success, NSArray *arr) {
        if (success) {
            
            NSMutableArray *arrTerm = [NSMutableArray arrayWithArray:self.arrData];
            [arrTerm addObjectsFromArray:arr];
            self.arrData = arrTerm;
            [self.tableView reloadData];
        }
        
        [ref endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static ChatMasterCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChatMasterCell class])];
    });
    [self configureCell:sizingCell forRowAtIndexPath:indexPath];
    
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+ 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrData.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self heightForBasicCellAtIndexPath:indexPath];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMasterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChatMasterCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(ChatMasterCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        cell.labelName.text = self.userName;
        cell.labelCOntent.text = self.comment;
        cell.buttonLike.hidden = self.isLIked;
        cell.labelName.textColor = [UIColor colorWithRed:166.0/255.0 green:232.0/255.0 blue:0.0 alpha:1.0];
        cell.labelCOntent.textColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:139.0/255.0 blue:169.0/255.0 alpha:1.0];
        
        [cell.buttonLike addTarget:self action:@selector(Like) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        ChatLevelTwoModel *model = self.arrData[indexPath.row -1];
        cell.labelName.text = model.user_name;
        cell.labelCOntent.text = model.comment_content;
        cell.buttonLike.hidden = YES;
        cell.labelName.textColor = [UIColor colorWithRed:68.0/255.0 green:161.0/255.0 blue:255.0/255.0 alpha:1.0];
        cell.labelCOntent.textColor = [UIColor blackColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(void)Like {
    [ChatStore postLikeWithObjectID:self.object_id Done:^(BOOL success) {
      
    }];
    
    ChatMasterCell *cell = (ChatMasterCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.buttonLike.hidden = YES;
    self.isLIked = YES;
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

- (IBAction)BinhLuan:(id)sender {
    
    if ([self.textfield.text isEqualToString:@""]|| self.textfield.text == nil) {
        [UIAlertView showWithTitle:@"Cảnh báo" message:@"Cần nhập bình luận trước khi gửi." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
    }
    else {
        [ChatStore postSubCommentWithComment:self.textfield.text ObjectId:self.object_id Done:^(BOOL success, NSArray *arr) {
            if (success) {
                self.arrData = arr;
                [self.tableView reloadData];
                self.textfield.text = @"";
                [self.textfield resignFirstResponder];
            }
        }];
    }
}
@end
