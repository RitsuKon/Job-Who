//
//  AppDelegate.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/24.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (strong, nonatomic) HomeViewController *homeVc;
@property (strong, nonatomic) LoginViewController *logVc;
@property (nonatomic, retain) BMKMapManager *managerMap;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    UINavigationController *navi = [UINavigationController alloc] initWithRootViewController:
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor lightGrayColor];
    [self mapManager];
    self.logVc = [[LoginViewController alloc] init];
    self.naviForLogin = [[UINavigationController alloc] initWithRootViewController:self.logVc];
    self.homeVc = [[HomeViewController alloc] init];
    OrderViewController *order = [[OrderViewController alloc] init];
    MyViewController *my = [[MyViewController alloc] init];
    self.homeVc.tabBarItem.image = [[UIImage imageNamed:@"主页 (1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.homeVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"主页.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.homeVc.tabBarItem.title = @"首页";
    order.tabBarItem.image = [[UIImage imageNamed:@"抢单 (1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    order.tabBarItem.selectedImage = [[UIImage imageNamed:@"抢单.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    order.tabBarItem.title = @"抢单";
    my.tabBarItem.image = [[UIImage imageNamed:@"我的 (1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    my.tabBarItem.selectedImage = [[UIImage imageNamed:@"我的.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    my.tabBarItem.title = @"我的";
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Color_System, UITextAttributeTextColor,nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:self.homeVc];
    self.tb = [[UITabBarController alloc] init];
    self.tb.viewControllers = @[navi,order,my];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        GuideViewController *guideVc = [[GuideViewController alloc] init];
        self.window.rootViewController = guideVc;
    } else {
        self.window.rootViewController = self.naviForLogin;
    }
   
    
    
    
    return YES;
}
#pragma mark - 百度地图管理
- (void)mapManager {
    self.managerMap = [[BMKMapManager alloc] init];
    BOOL ret = [self.managerMap start:@"5pNIjH3NnhOj4Y24aqHczt2YkShmEGgH" generalDelegate:nil];
    if (!ret) {
        NSLog(@"failed");
    } else {
        NSLog(@"走么");
    }

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
