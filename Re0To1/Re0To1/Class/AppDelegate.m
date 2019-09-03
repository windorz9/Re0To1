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
#import "ZXSplashView.h"
#import "ZXStaticFrameworkTest.h"
//#import <ZXFramework/ZXFramework.h>
//#import <ZXFramework/ZXFrameworkTest.h>
#import "ZXMineViewController.h"
#import <execinfo.h>
#import "ZXLocation.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.view.backgroundColor = [UIColor whiteColor];
    
    ZXNewsViewController *newsViewController = [[ZXNewsViewController alloc] init];
    
    ZXVideoViewController *videoController = [[ZXVideoViewController alloc] init];
    
    ZXReCommendViewController *recommendController = [[ZXReCommendViewController alloc] init];
    
    ZXMineViewController *mineViewController = [[ZXMineViewController alloc] init];
    tabBarController.viewControllers = @[newsViewController, videoController, recommendController, mineViewController];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    navigationController.view.backgroundColor = [UIColor whiteColor];
//    navigationController.navigationBar.translucent = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navigationController;
//    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 添加一个自定义的闪屏 view 添加到上面去
    ZXSplashView *splashView = [[ZXSplashView alloc] initWithFrame:self.window.bounds];
    [self.window addSubview:splashView];
    
    // 收集错误的信息
//    [self _caughtException];
//    [@[].mutableCopy addObject:nil];
    
    // 测试静态库
//    [[ZXStaticFrameworkTest alloc] init];
    
    // 测试动态库
    // Framework 并不一定就是动态库, framework 只是资源的一种打包方式,
    // 真正决定是否是动态库取决于 buildSetting 里面的 Mach-O Type 的设置.
//    [[ZXStaticFrameworkTest alloc] init];
    
    // 监听位置信息
    [[ZXLocation locationManager] checkLocationAuthorization];
    

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

// 被外界 app 通过 Scheme 调用
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    /**
     {
     UIApplicationOpenURLOptionsOpenInPlaceKey = 0;
     UIApplicationOpenURLOptionsSourceApplicationKey = "com.apple.mobilesafari";
     }
     */
    NSLog(@"被其他 app 调启 %@", options);
    return YES;
}

#pragma mark Crash
- (void)_caughtException {
    
    // 收集 NSException
    NSSetUncaughtExceptionHandler(HandleNSException);
    
    // 收集信号量错误信息 signal
    signal(SIGABRT, HandleSignalException);
    signal(SIGILL, HandleSignalException);
    signal(SIGSEGV, HandleSignalException);
    signal(SIGFPE, HandleSignalException);
    signal(SIGBUS, HandleSignalException);
    signal(SIGPIPE, HandleSignalException);

}

void HandleSignalException(int signal) {
    
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    // 存储 crash 信息
    
    
    
}

void HandleNSException(NSException *exception) {
    
    __unused NSString *reason = [exception reason];
    __unused NSString *name = [exception name];
    // 存储 Crash 信息 可以进行上报
    
    
}

@end
