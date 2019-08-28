//
//  AppDelegate.m
//  Re0To1
//
//  Created by windorz on 2019/6/4.
//  Copyright © 2019 Q. All rights reserved.
//

#import "AppDelegate.h"
#import "ZXNewsViewController.h"
#import "ZXVideoViewController.h"
#import "ZXReCommendViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.view.backgroundColor = [UIColor whiteColor];
    
    ZXNewsViewController *newsViewController = [[ZXNewsViewController alloc] init];
    
    ZXVideoViewController *videoController = [[ZXVideoViewController alloc] init];
    
    ZXReCommendViewController *recommendController = [[ZXReCommendViewController alloc] init];
    
    UIViewController *mineViewController = [[UIViewController alloc] init];
    mineViewController.tabBarItem.title = @"我的";
    mineViewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
    mineViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon/home_selected@2x.png"];
    mineViewController.view.backgroundColor = [UIColor orangeColor];

    tabBarController.viewControllers = @[newsViewController, videoController, recommendController, mineViewController];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    navigationController.view.backgroundColor = [UIColor whiteColor];
//    navigationController.navigationBar.translucent = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navigationController;
//    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    


    return YES;
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
