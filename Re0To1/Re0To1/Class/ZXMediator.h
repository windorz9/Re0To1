//
//  ZXMediator.h
//  Re0To1
//
//  Created by windorz on 2019/8/31.
//  Copyright © 2019 Q. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 负责测试简单的组件化
 */
typedef void(^ZXMediatorProcessBlock)(NSDictionary *params);

@protocol ZXDetailViewControllerProtocol <NSObject>

- (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

@end

@interface ZXMediator : NSObject
#pragma mark Target Action
+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

#pragma mark URL Scheme
// 注册 URL 然后 打开 URL
+ (void)registerSchemeUrl:(NSString *)urlString processBlock:(ZXMediatorProcessBlock)processBlock;
+ (void)openUrl:(NSString *)urlString params:(NSDictionary *)params;

#pragma mark Protocol Class
// 注册协议, 从注册的协议里面返回对应的类
+ (void)registerProtocol:(Protocol *)protocol class:(Class)cls;
+ (Class)classForProtocol:(Protocol *)protocol;

@end


