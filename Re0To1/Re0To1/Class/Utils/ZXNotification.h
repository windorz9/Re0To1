//
//  ZXNotification.h
//  Re0To1
//
//  Created by windorz on 2019/9/3.
//  Copyright © 2019 Q. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 统一管理应用的通知
 */
@interface ZXNotification : NSObject

/**
 通知管理单例

 @return 返回单例
 */
+ (ZXNotification *)notificationManager;


/**
 校验当前是否开启通知权限
 */
- (void)checkNotificationAuthorization;
@end

NS_ASSUME_NONNULL_END
