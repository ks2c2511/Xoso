//
//  ThongkeSoController.m
//  XoSo
//
//  Created by Khoa Le on 8/5/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "ThongkeSoController.h"
#import <UIColor+uiGradients.h>
#import "ThongkeDacbiet.h"
#import "CustomSegment.h"
#import "ThongkeChuave.h"

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
@property (assign,nonatomic) NSInteger selectIndex;
- (IBAction)SelectType:(id)sender;
@end

@implementation ThongkeSoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = view.bounds;
//    gradient.startPoint = CGPointMake(0, 0);
//    gradient.endPoint = CGPointMake(view.frame.size.width, 0);
//    gradient.colors = @[(id)[startColor CGColor], (id)[endColor CGColor], nil];
//    
//    [view.layer insertSublayer:gradient atIndex:0];
    // Do any additional setup after loading the view from its nib.
    
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
//        tbController.keyPath = _arrayKeyPath[type];
//        tbController.respondObject = _respondObject;
        
        return tbController;
    }
    else if (type == ContentTypeChuave) {
        
        
        ThongkeChuave *tbController = [ThongkeChuave new];
        tbController.typeIndex = type;
        //        tbController.keyPath = _arrayKeyPath[type];
        //        tbController.respondObject = _respondObject;
        
        return tbController;
    }
    
    return nil;
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
@end
