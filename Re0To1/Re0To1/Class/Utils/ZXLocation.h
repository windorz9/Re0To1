//
//  ZXLocation.h
//  Re0To1
//
//  Created by windorz on 2019/9/3.
//  Copyright © 2019 Q. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 统一管理 App 的位置信息
 */
@interface ZXLocation : NSObject

/**
 获取单例

 @return 位置信息管理单例
 */
+ (ZXLocation *)locationManager;

/**
 检查当前的应用的位置信息权限
 */
- (void)checkLocationAuthorization;

@end

NS_ASSUME_NONNULL_END
