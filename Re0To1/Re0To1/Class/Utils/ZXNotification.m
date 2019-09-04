//
//  ZXNotification.m
//  Re0To1
//
//  Created by windorz on 2019/9/3.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXNotification.h"
#import <UserNotifications/UserNotifications.h> // iOS 10 以后统一了本地推送和远程推送
#import <UIKit/UIKit.h>

@interface ZXNotification () <UNUserNotificationCenterDelegate>

@end

@implementation ZXNotification

+ (ZXNotification *)notificationManager {
    static ZXNotification *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZXNotification alloc] init];
    });
    return manager;
}

- (void)checkNotificationAuthorization {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError *_Nullable error) {
        if (granted) {
            NSLog(@"已开启通知权限");
            // 向远程服务器注册 Notification
            dispatch_async(dispatch_get_main_queue(), ^{
                               [[UIApplication sharedApplication] registerForRemoteNotifications];
                           });
            // 有权限则测试通知
            [self _pushLocalNotification];
        }
    }];
}

#pragma mark 本地推送
- (void)_pushLocalNotification {
    // 0. 创建 Content
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.badge = @(2);
    content.title = @"本地推送";
    content.body = @"这是一次本地推送测试";

    // 1. 创建 Trigger
    // 10s 后弹出并不重复
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10.0f repeats:NO];

    // 2. 组合成一个 Request
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"_pushLocalNotification" content:content trigger:trigger];

    // 3. 通知中心处理
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
        NSLog(@"成功添加上一个本地通知");
    }];
}

#pragma mark UNUserNotificationCenterDelegate
// 将要弹出通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    // 设置弹出类型
    completionHandler(UNNotificationPresentationOptionAlert);
}

// 接收到点击对应的通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    completionHandler();
    NSLog(@"点击了通知");
}

@end
