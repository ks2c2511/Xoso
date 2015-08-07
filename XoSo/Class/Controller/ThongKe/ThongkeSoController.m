//
//  ThongkeSoController.m
//  XoSo
//
//  Created by Khoa Le on 8/5/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeSoController.h"
#import "ThongkeDacbiet.h"
#import "CustomSegment.h"
#import "ThongkeChuave.h"
#import "TableListItem.h"
#import "Province.h"
#import <NSManagedObject+GzDatabase.h>

typedef NS_ENUM(NSInteger, ContentType) {
    ContentTypeDacbiet,
    ContentTypeLoto,
    ContentTypeChuave
};

@interface ThongkeSoController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (weak, nonatomic) IBOutlet UIButton *buttonNameSoxo;
@property (weak, nonatomic) IBOutlet UIButton *buttonLanquay;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (strong,nonatomic) UIPageViewController *pageController;
@property (weak, nonatomic) IBOutlet CustomSegment *segmentType;
@property (strong,nonatomic) TableListItem *tableListItem;
@property (strong,nonatomic) TableListItem *tableSoluong;
@property (assign,nonatomic) NSInteger selectIndex;
@property (assign,nonatomic) NSInteger matinh,luotquay;
- (IBAction)SelectType:(id)sender;
- (IBAction)SelectSoluong:(UIButton *)sender;

- (IBAction)SelectCity:(UIButton *)sender;

@end

@implementation ThongkeSoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Thống kê từ 00 - 99";
    self.matinh = 1;
    self.luotquay = 10;
    
    [self createPageCOntroller];
}

-(void)createPageCOntroller {
    if (_pageController == nil) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.view.frame = _viewBackground.bounds;
        _pageController.dataSource = self;
        _pageController.delegate = self;
        _pageController.view.backgroundColor = [UIColor clearColor];
        [_pageController setViewControllers:@[[self contentViewWithType:ContentTypeDacbiet]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
        [self addChildViewController:self.pageController];
        [self.viewBackground addSubview:_pageController.view];
    }
    
}

#pragma mark - UIpageViewCOntroller Delegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger indexNumber;
    
    if ([viewController isKindOfClass:[ThongkeDacbiet class]]) {
        indexNumber = [(ThongkeDacbiet *)viewController typeIndex];
    }
    else {
        indexNumber = [(ThongkeChuave *)viewController typeIndex];
    }
    if (indexNumber == 0) {
        return nil;
    }
    indexNumber --;
    
    return [self contentViewWithType:(ContentType)indexNumber];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger indexNumber;
    
    if ([viewController isKindOfClass:[ThongkeDacbiet class]]) {
        indexNumber = [(ThongkeDacbiet *)viewController typeIndex];
    }
    else {
        indexNumber = [(ThongkeChuave *)viewController typeIndex];
    }
    
    if (indexNumber == 2) {
        return nil;
    }
    
    indexNumber ++;
    return [self contentViewWithType:(ContentType)indexNumber];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if (!completed)
    {
        return;
    }
    
    
    NSInteger index = [[pageViewController.viewControllers objectAtIndex:0] typeIndex];
    
    [self.segmentType setSelectedSegmentIndex:index];
    _selectIndex = index;

}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    return 0;
}



-(UIViewController *)contentViewWithType:(ContentType )type {
    
    if (type == ContentTypeDacbiet || type == ContentTypeLoto ) {
        ThongkeDacbiet *tbController = [ThongkeDacbiet new];
        tbController.typeIndex = type;
        tbController.matinh = self.matinh;
        tbController.luotquay = self.luotquay;

        return tbController;
    }
    else if (type == ContentTypeChuave) {
        
        
        ThongkeChuave *tbController = [ThongkeChuave new];
        tbController.typeIndex = type;
        tbController.matinh = self.matinh;
        tbController.luotquay = self.luotquay;
        
        return tbController;
    }
    
    return nil;
}

-(TableListItem *)tableListItem {
    if (!_tableListItem) {
        _tableListItem = [[TableListItem alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableListItem.arrData = [Province fetchAll];
        [_tableListItem setTableViewCellConfigBlock:^(TableListCell *cell ,Province *pro) {
            cell.labelTttle.text = pro.province_name;
            if (self.matinh == [pro.province_id integerValue]) {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_checked_white.png"]];
            }
            else {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_unchecked_white.png"]];
            }
        }];

        __weak typeof(self)weakSelf = self;
        [_tableListItem setSelectItem:^(NSIndexPath *indexPath, Province *pro) {
            [weakSelf.buttonNameSoxo setTitle:pro.province_name forState:UIControlStateNormal];
            weakSelf.matinh = [pro.province_id integerValue];

            [weakSelf.tableListItem reloadData];

            [weakSelf setViewWithIndex:weakSelf.selectIndex];
        }];

        [self.view addSubview:_tableListItem];
    }

    return _tableListItem;
}

-(TableListItem *)tableSoluong {
    if (!_tableSoluong) {
        _tableSoluong = [[TableListItem alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableSoluong.arrData = @[@"10",@"20",@"30",@"60",@"100",@"365"];
        [_tableSoluong setTableViewCellConfigBlock:^(TableListCell *cell ,NSString *number) {
            cell.labelTttle.text = number;
            if (self.luotquay == [number integerValue]) {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_checked_white.png"]];
            }
            else {
                [cell.imageIconSelect setImage:[UIImage imageNamed:@"ic_radio_button_unchecked_white.png"]];
            }
        }];

        __weak typeof(self)weakSelf = self;
        [_tableSoluong setSelectItem:^(NSIndexPath *indexPath, NSString *number) {
            [weakSelf.buttonLanquay setTitle:number forState:UIControlStateNormal];
            weakSelf.luotquay = [number integerValue];

            [weakSelf.tableSoluong reloadData];

            [weakSelf setViewWithIndex:weakSelf.selectIndex];
        }];

        [self.view addSubview:_tableSoluong];
    }
    
    return _tableSoluong;
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

- (IBAction)SelectType:(id)sender {
    CustomSegment *seg = (CustomSegment *)sender;

    if (seg.selectedSegmentIndex == self.selectIndex) {
        return;
    }
    UIPageViewControllerNavigationDirection direction;
    if (seg.selectedSegmentIndex > self.selectIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }

    [_pageController setViewControllers:[NSArray arrayWithObjects:[self contentViewWithType:(ContentType)seg.selectedSegmentIndex], nil] direction:direction animated:YES completion:^(BOOL finished) {

    }];

    _selectIndex = seg.selectedSegmentIndex;

}

- (IBAction)SelectSoluong:(UIButton *)sender {

    self.tableSoluong.frame = ({
        CGRect frame = self.buttonLanquay.frame;
        frame.origin.x = CGRectGetMinX(self.buttonLanquay.frame) - 50;
        frame.origin.y = CGRectGetMaxY(self.buttonLanquay.frame);
        frame.size.width = CGRectGetWidth(self.buttonLanquay.frame) +50;
        frame.size.height = 250;
        frame;
    });
    [self.tableSoluong showOrHiden];
}

-(void)setViewWithIndex:(NSInteger)index {

    UIPageViewControllerNavigationDirection direction;
    if (index > self.selectIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }

    [_pageController setViewControllers:[NSArray arrayWithObjects:[self contentViewWithType:(ContentType)index], nil] direction:direction animated:NO completion:^(BOOL finished) {

    }];

    _selectIndex = index;
    self.segmentType.selectedSegmentIndex = index;
}

- (IBAction)SelectCity:(UIButton *)sender {
    self.tableListItem.frame = ({
        CGRect frame = self.buttonNameSoxo.frame;
        frame.origin.y = CGRectGetMaxY(self.buttonNameSoxo.frame);
        frame.size.width = CGRectGetWidth(self.buttonNameSoxo.frame);
        frame.size.height = [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.buttonNameSoxo.frame) - HeightNavigationBar;
        frame;
    });
    [self.tableListItem showOrHiden];
}
@end
