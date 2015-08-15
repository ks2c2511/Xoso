//
//  ChatLevelOneController.m
//  XoSo
//
//  Created by Khoa Le on 8/15/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ChatLevelOneController.h"
#import "ChatStore.h"
#import "ChatLeverOneCell.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
#import <UIAlertView+Blocks.h>
#import "ChatLevelTwoController.h"

@interface ChatLevelOneController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong,nonatomic) NSArray *arrData;
@property (assign,nonatomic) NSInteger currentPage;
@property (strong,nonatomic) NSDateFormatter *dateFormatter;
- (IBAction)BinhLuan:(id)sender;

@end

@implementation ChatLevelOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Phòng chat";
    _currentPage = 1;
    [self.tableView registerClass:[ChatLeverOneCell class] forCellReuseIdentifier:NSStringFromClass([ChatLeverOneCell class])];
    // Do any additional setup after loading the view from its nib.
    
    
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
}

-(void)viewWillAppear:(BOOL)animated {
    [ChatStore getChatLevelOneWithPage:self.currentPage Done:^(BOOL success, NSArray *arr) {
        if (success) {
            self.arrData = arr;
            [self.tableView reloadData];
        }
    }];

}

-(void)refresh:(UIRefreshControl *)ref {
    self.currentPage += 1;
    [ChatStore getChatLevelOneWithPage:self.currentPage Done:^(BOOL success, NSArray *arr) {
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
    static ChatLeverOneCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChatLeverOneCell class])];
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
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self heightForBasicCellAtIndexPath:indexPath];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatLeverOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChatLeverOneCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)configureCell:(ChatLeverOneCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatLeverOneModel *model = self.arrData[indexPath.row];
    cell.labelName.text = model.user_name;
    cell.labelContent.text = model.subject_content;
    cell.labelComment.text = [NSString stringWithFormat:@"%@ Bình luận",model.comment_count];
    cell.labelDate.text = [NSString stringWithFormat:@"%@",[self.dateFormatter stringFromDate:model.create_date]];
    cell.labelLike.text = [NSString stringWithFormat:@"%@",model.like_count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     ChatLeverOneModel *model = self.arrData[indexPath.row];
    ChatLevelTwoController *chat = [ChatLevelTwoController new];
    chat.object_id = model.subject_id;
    chat.userName = model.user_name;
    chat.comment = model.subject_content;
    [self.navigationController pushViewController:chat animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"dd-MM-yyyy"];
    }
    return _dateFormatter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BinhLuan:(id)sender {
    if ([self.textField.text isEqualToString:@""]|| self.textField.text == nil) {
    [UIAlertView showWithTitle:@"Cảnh báo" message:@"Cần nhập bình luận trước khi gửi." cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
    }
    else {
        [ChatStore postCommentWithComment:self.textField.text Done:^(BOOL success, NSArray *arr) {
            if (success) {
                self.arrData = arr;
                [self.tableView reloadData];
                self.textField.text = @"";
                [self.textField resignFirstResponder];
            }
        }];
    }
}
@end
