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
#import <FMDB.h>
#import <NSManagedObject+GzDatabase.h>
#import "Province.h"
#import "Lotery.h"
#import "Dream.h"
#import "SplashController.h"
#import "ManageUserController.h"
#import "LoginOtherUserController.h"
#import "ThongtinController.h"
#import "HuongDanController.h"
#import "HopThuController.h"
#import <GAI.h>
#import <GAIDictionaryBuilder.h>
#import "XPush.h"
#import "TuongThuatController.h"
#import "KiemxuController.h"
#import "DangkiController.h"
#import "CaidatController.h"
#import <StartApp/StartApp.h>
#import "NaptheStore.h"

@interface AppDelegate () <ECSlidingViewControllerDelegate>
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIScreenEdgePanGestureRecognizer *panScreenGesture;
@property (strong, nonatomic) UISwipeGestureRecognizer *panLeftToCloseMenu;
@property (nonatomic, strong) void (^registrationHandler)
(NSString *registrationToken, NSError *error);
@property (nonatomic, assign) BOOL connectedToGCM;
@property (nonatomic, strong) NSString *registrationToken;
@property (nonatomic, assign) BOOL subscribedToTopic;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self CustomTheme];
    //    [self showMainIsOnApp];

    


    self.window.rootViewController = [SplashController new];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showMainIsOnApp];
    });
    [self notificationImplement];

    [GzDatabase ShareDatabaseWithDatamodel:@"Xoso" sqliteName:@"Xoso"];

    [self.window makeKeyAndVisible];

    if (![[NSUserDefaults standardUserDefaults] boolForKey:user_default_loaded_local_database]) {
        NSString *pathToResource = [[NSBundle mainBundle] pathForResource:@"mydb" ofType:@"db"];

        NSLog(@"---> start %@", [NSDate date]);
        FMDatabase *DB =  [FMDatabase databaseWithPath:pathToResource];
        [DB open];


        FMResultSet *results_lotery = [DB executeQuery:@"select * from lottery_schedules"];

        while ([results_lotery next]) {
            Lotery *lotery = [Lotery CreateEntityDescription];
            lotery.day_id = @([results_lotery intForColumn:@"DAY_ID"]);
            lotery.company_id = @([results_lotery intForColumn:@"COMPANY_ID"]);
            lotery.lotery_id = @([results_lotery intForColumn:@"id"]);
            //        NSLog(@"User: %@",name);
        }

        FMResultSet *results = [DB executeQuery:@"select * from LOTTERY_PROVINCE"];

        while ([results next]) {
            Province *province = [Province CreateEntityDescription];
            province.province_id = @([results intForColumn:@"province_id"]);
            province.province_name = [results stringForColumn:@"province"];
            province.province_group = @([results intForColumn:@"province_group"]);
            province.check_city = @([results intForColumn:@"checkcity"]);
            //        NSLog(@"User: %@",name);
        }

        FMResultSet *resultsDream = [DB executeQuery:@"select * from dream"];

        while ([resultsDream next]) {
            Dream *dream = [Dream CreateEntityDescription];
            dream.dream_id = @([resultsDream intForColumn:@"id"]);
            dream.so = [resultsDream stringForColumn:@"so"];
            dream.ten = [resultsDream stringForColumn:@"ten"];
        }

        [GzDatabase saveToPersistentStore];
        [DB close];

        NSLog(@"---> end %@", [NSDate date]);

        NSArray *arr = [Province fetchAll];
        NSLog(@"---> arrProvince : %lu", (unsigned long)[arr count]);


        NSArray *arrD = [Dream fetchAll];
        NSLog(@"---> dreameCount : %lu", (unsigned long)[arrD count]);

        NSArray *arrL = [Lotery fetchAll];
        NSLog(@"---> dreameCount : %lu", (unsigned long)[arrL count]);

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:user_default_loaded_local_database];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showManageUserScreen) name:notificationShowManageUser object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginOtherUser) name:notificationShowLoginOtherUser object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfo) name:notificationShowInfoUser object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHome) name:notification_show_home object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHuongdan) name:notificationShowHuongDanUser object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHomThu) name:notificationShowHopthu object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDangki) name:notificationShowDangki object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCaidat) name:notificationCaiDat object:nil];




    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;

    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;

    // Optional: set Logger to VERBOSE for debug information.




    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-45319055-8"];

    id <GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    tracker.allowIDFACollection = YES;

    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Open APP"     // Event category (required)
                                                          action:@"" // Event action (required)
                                                           label:@""          // Event label
                                                           value:nil] build]];    // Event value


    //lots of your initialization code

    // Setup XtremePUSH
    NSInteger types;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.f) {
        types = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
    }
    else {
        types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
    }

    [XPush registerForRemoteNotificationTypes:types];

    [XPush applicationDidFinishLaunchingWithOptions:launchOptions];



    //     local notitication (Thông báo khi quay xong)
    if ([[NSUserDefaults standardUserDefaults] boolForKey:key_push_alert_mien_bac_quay_so]) {
        [self scheduleAlarmForHOur:18 Minute:30 message:@"Đã có kết quả xổ số miền Bắc" key:key_push_alert_mien_bac_quay_so];
    }
    else {
        for (UILocalNotification *localNotification in[[UIApplication sharedApplication] scheduledLocalNotifications]) {
            if ([[localNotification.userInfo valueForKey:key_push_alert_mien_bac_quay_so] isEqualToString:key_push_alert_mien_bac_quay_so]) {
                [[UIApplication sharedApplication] cancelLocalNotification:localNotification];  // delete the notification from the system
            }
        }
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:key_push_alert_mien_trung_quay_so]) {
        [self scheduleAlarmForHOur:17 Minute:30 message:@"Đã có kết quả xổ số miền Trung" key:key_push_alert_mien_trung_quay_so];
    }
    else {
        for (UILocalNotification *localNotification in[[UIApplication sharedApplication] scheduledLocalNotifications]) {
            if ([[localNotification.userInfo valueForKey:key_push_alert_mien_trung_quay_so] isEqualToString:key_push_alert_mien_trung_quay_so]) {
                [[UIApplication sharedApplication] cancelLocalNotification:localNotification];  // delete the notification from the system
            }
        }
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:key_push_alert_mien_nam_quay_so]) {
        [self scheduleAlarmForHOur:16 Minute:30 message:@"Đã có kết quả xổ số miền Nam" key:key_push_alert_mien_nam_quay_so];
    }
    else {
        for (UILocalNotification *localNotification in[[UIApplication sharedApplication] scheduledLocalNotifications]) {
            if ([[localNotification.userInfo valueForKey:key_push_alert_mien_nam_quay_so] isEqualToString:key_push_alert_mien_nam_quay_so]) {
                [[UIApplication sharedApplication] cancelLocalNotification:localNotification];  // delete the notification from the system
            }
        }
    }

    STAStartAppSDK* sdk = [STAStartAppSDK sharedInstance];
    sdk.appID = @"208348443";
    sdk.devID =@"103281770";
    [sdk disableReturnAd];
    
    
    [NaptheStore checkShowNaptheWithDone:^(BOOL show) {
        [[NSUserDefaults standardUserDefaults] setBool:show forKey:key_turn_on_nap_the];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
   


    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [XPush applicationDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    BOOL showAlert = YES;//should or not library shows alert for this push.
    [XPush applicationDidReceiveRemoteNotification:userInfo showAlert:showAlert];

    for (NSString *key in[userInfo allKeys]) {
        if ([key isEqualToString:@"message"]) {
            if (!self.navigationController) {
                [self showMainIsOnApp];
            }
            [self showHome];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:pushNotifiReceiveRemotePush object:nil userInfo:userInfo];
            });
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [XPush applicationDidFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)notificationImplement {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowLeftMenu) name:notification_show_left_menu object:nil];
}

#pragma mark - Show main app when On app
- (void)showMainIsOnApp {
    HomeController *home = [HomeController new];
    MenuController *menu = [MenuController new];

    self.navigationController = [[UINavigationController alloc] initWithRootViewController:home];
    [self.navigationController.view addGestureRecognizer:self.panScreenGesture];
    self.panScreenGesture.cancelsTouchesInView = YES;
    [self.navigationController.view addGestureRecognizer:self.panLeftToCloseMenu];

    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:self.navigationController];

    self.slidingViewController.underLeftViewController  = menu;

    self.slidingViewController.anchorRightPeekAmount  = [UIScreen mainScreen].bounds.size.width - ([UIScreen mainScreen].bounds.size.width / ratioMenuAndMainView);

    [self.slidingViewController setDelegate:self];

    [self.window setRootViewController:self.slidingViewController];
}

- (void)ShowLeftMenu {
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        //===========================================================
        //  Close
        //===========================================================
       [self CloseMenu];
    }
    else if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionCentered) {
        //===========================================================
        //  Open
        //===========================================================
        [self.slidingViewController anchorTopViewToRightAnimated:YES onComplete: ^{
        }];
        self.panLeftToCloseMenu.enabled = YES;
        self.navigationController.visibleViewController.view.userInteractionEnabled = NO;
    }
}

-(void)CloseMenu {
    [self.slidingViewController resetTopViewAnimated:YES onComplete: ^{
    }];
    self.panLeftToCloseMenu.enabled = NO;
    self.navigationController.visibleViewController.view.userInteractionEnabled = YES;
}

- (void)showManageUserScreen {
    ManageUserController *user = [ManageUserController new];
    self.navigationController.viewControllers = @[user];
     [self CloseMenu];

   
}

- (void)showLoginOtherUser {
    LoginOtherUserController *user = [LoginOtherUserController new];
    self.navigationController.viewControllers = @[user];

    [self CloseMenu];
}

- (void)showHuongdan {
    HuongDanController *user = [HuongDanController new];
    self.navigationController.viewControllers = @[user];

    [self CloseMenu];
}

- (void)showHomThu {
    HopThuController *email = [HopThuController new];
    self.navigationController.viewControllers = @[email];

    [self CloseMenu];
}

- (void)showDangki {
    DangkiController *email = [DangkiController new];
    self.navigationController.viewControllers = @[email];

    [self CloseMenu];
}

- (void)showCaidat {
    CaidatController *caidat = [CaidatController new];
    self.navigationController.viewControllers = @[caidat];

    [self CloseMenu];
}

- (void)showInfo {
    ThongtinController *tt = [ThongtinController new];
    self.navigationController.viewControllers = @[tt];

    [self CloseMenu];
}

- (void)showHome {
    HomeController *home = [HomeController new];
    self.navigationController.viewControllers = @[home];

    [self CloseMenu];
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
                                                           NSForegroundColorAttributeName : [UIColor blackColor],
                                                           NSFontAttributeName : [UIFont boldSystemFontOfSize:17.0]
                                                           } forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor blackColor],
                                                           NSFontAttributeName : [UIFont boldSystemFontOfSize:17.0]
                                                           } forState:UIControlStateHighlighted];

    [self.navigationController.navigationBar setTranslucent:NO];
}

#pragma mark - panGesture

- (UIScreenEdgePanGestureRecognizer *)panScreenGesture {
    if (!_panScreenGesture) {
        _panScreenGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(ShowLeftMenu)];
        _panScreenGesture.edges = UIRectEdgeLeft;
    }
    return _panScreenGesture;
}

-(UISwipeGestureRecognizer *)panLeftToCloseMenu {
    if (!_panLeftToCloseMenu) {
        _panLeftToCloseMenu = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ShowLeftMenu)];
        _panLeftToCloseMenu.enabled = NO;
        _panLeftToCloseMenu.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    
    return _panLeftToCloseMenu;
}

- (void)scheduleAlarmForHOur:(NSInteger)hour Minute:(NSInteger)phut message:(NSString *)msg key:(NSString *)key {
    //====== TO SEE OLD NOTIFI=======
    UIApplication *Ap = [UIApplication sharedApplication];
    NSArray *arr = [Ap scheduledLocalNotifications];
    NSLog(@"Old Notifications :>> %@", arr);

    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *alarm = [[UILocalNotification alloc] init];

    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:now];
    [components setHour:hour];
    [components setMinute:phut];
    NSDate *next9am = [calendar dateFromComponents:components];
    if ([next9am timeIntervalSinceNow] < 0) {
        // If today's 9am already occurred, add 24hours to get to tomorrow's
        next9am = [next9am dateByAddingTimeInterval:60 * 60 * 24];
    }

    // Create a new notification
    alarm.fireDate = next9am;
    NSLog(@"fireDate IS >> %@", alarm.fireDate);
    alarm.timeZone = [NSTimeZone localTimeZone];
    alarm.alertBody = msg;
    NSLog(@"msg IS >> %@", msg);
    alarm.alertAction = @"Show";
    alarm.repeatInterval = NSDayCalendarUnit * 24 * 60; // it repeat every day ,set it as per you want

    alarm.soundName = UILocalNotificationDefaultSoundName;
    alarm.applicationIconBadgeNumber = 0;

    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:key forKey:key];
    alarm.userInfo = infoDict;
    [app scheduleLocalNotification:alarm];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
