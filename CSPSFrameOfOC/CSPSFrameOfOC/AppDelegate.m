//
//  AppDelegate.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "Macro.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "ActivityViewController.h"
#import "MeViewController.h"
#import "AreaCache.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [AreaCache getAreas];
    
    [self buildMainView];
    [self.window makeKeyAndVisible];
    
    return YES;
}

//初始化
- (void)buildMainView {
    HomeViewController *homeVC = [HomeViewController loadFromSB];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                      image:SOImage(@"tabbars_home_normal")
                                              selectedImage:SOImage(@"tabbars_home_sel")];
    
    NewsViewController *newsVC = [NewsViewController new];
    newsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻"
                                                      image:SOImage(@"tabbars_news_normal")
                                              selectedImage:SOImage(@"tabbars_news_sel")];
    
    ActivityViewController *activityVC = [ActivityViewController loadFromSB];
    activityVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"活动"
                                                          image:SOImage(@"tabbars_activity_nor")
                                                  selectedImage:SOImage(@"tabbars_activity_sel")];
    
    MeViewController *meVC = [MeViewController loadFromSB];
    meVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                    image:SOImage(@"tabbars_me_normal")
                                            selectedImage:SOImage(@"tabbars_me_sel")];
    
    UITabBarController *mainVC = [[UITabBarController alloc] init];
    mainVC.viewControllers = @[packInNav(homeVC),
                               packInNav(newsVC),
                               packInNav(activityVC),
                               packInNav(meVC)];
    self.window.rootViewController = mainVC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
