//
//  AppDelegate.m
//  XoSo
//
//  Created by Khoa Le on 7/3/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "AppDelegate.h"
#import <ECSlidingViewController.h>
#import "UIImage+DrawColor.h"
#import "UIColor+AppTheme.h"
#import "ConstantDefine.h"
#import "HomeController.h"
#import "MenuController.h"

@interface AppDelegate () <ECSlidingViewControllerDelegate>
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;
@property (strong,nonatomic) UINavigationController *navigationController;
@property (strong,nonatomic) UIScreenEdgePanGestureRecognizer *panScreenGesture;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self CustomTheme];
    [self showMainIsOnApp];
    [self notificationImplement];
    
    [self.window makeKeyAndVisible];

    
    return YES;
}

-(void)notificationImplement {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowLeftMenu) name:notification_show_left_menu object:nil];
}

#pragma mark - Show main app when On app
-(void)showMainIsOnApp {
    HomeController *home = [HomeController new];
    MenuController *menu = [MenuController new];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:home];
    [self.navigationController.view addGestureRecognizer:self.panScreenGesture];
    
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:self.navigationController];
    
    self.slidingViewController.underLeftViewController  = menu;
    
    self.slidingViewController.anchorRightPeekAmount  = [UIScreen mainScreen].bounds.size.width - ([UIScreen mainScreen].bounds.size.width/ratioMenuAndMainView);
    
    [self.slidingViewController setDelegate:self];
    
    [self.window setRootViewController:self.slidingViewController];
    
}

-(void)ShowLeftMenu{
    if(self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight)
    {
        //===========================================================
        //  Close
        //===========================================================
        [self.slidingViewController resetTopViewAnimated:YES onComplete:^{
        }];
    }
    else if(self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionCentered){
        //===========================================================
        //  Open
        //===========================================================
        [self.slidingViewController anchorTopViewToRightAnimated:YES onComplete:^{
        }];
    }
}
#pragma mark - custom Navigaton
- (void)CustomTheme {
    //===========================================================
    //  UINavigationBar
    //===========================================================
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance]
     setBackgroundImage:[UIImage DrawImageWithSize:CGSizeMake(
                                                              [UIScreen mainScreen]
                                                              .bounds.size.width,
                                                              HeightNavigationBar)
                                             Color:@[[UIColor appNavigationBarColor]]]
     forBarMetrics:UIBarMetricsDefault];
    if ([UINavigationBar
         instancesRespondToSelector:@selector(setBackIndicatorImage:)]) {  // iOS 7
        [[UINavigationBar appearance]
         setBackIndicatorImage:
         [[UIImage imageNamed:@"navigation_back"]
          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [[UINavigationBar appearance]
         setBackIndicatorTransitionMaskImage:
         [[UIImage imageNamed:@"navigation_back"]
          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [UIBarButtonItem.appearance
         setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -120.0)
         forBarMetrics:UIBarMetricsDefault];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           NSFontAttributeName : [UIFont boldSystemFontOfSize:17.0]
                                                           }];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           NSFontAttributeName : [UIFont boldSystemFontOfSize:17.0]
                                                           } forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           NSFontAttributeName : [UIFont boldSystemFontOfSize:17.0]
                                                           } forState:UIControlStateHighlighted];
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    
   
}

#pragma mark - panGesture

-(UIScreenEdgePanGestureRecognizer *)panScreenGesture {
    if (!_panScreenGesture) {
        _panScreenGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(ShowLeftMenu)];
        _panScreenGesture.edges = UIRectEdgeLeft;
        
    }
    return _panScreenGesture;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
