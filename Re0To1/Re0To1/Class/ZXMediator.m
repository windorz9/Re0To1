//
//  ZXMediator.m
//  Re0To1
//
//  Created by windorz on 2019/8/31.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXMediator.h"
//#import "ZXDetailViewController.h"

@implementation ZXMediator

#pragma mark Target-Action
+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl {
//    ZXDetailViewController *detailViewController = [[ZXDetailViewController alloc] initWithUrlString:detailUrl];
//    return detailViewController;

    Class cls = NSClassFromString(@"ZXDetailViewController");
    __kindof UIViewController *controller = [[cls alloc] performSelector:NSSelectorFromString(@"initWithUrlString:") withObject:detailUrl];
    return controller;
}

#pragma mark URL Scheme
+ (NSMutableDictionary *)mediatorCache {
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = @{}.mutableCopy;
    });
    return cache;
}

// 注册某个 scheme
+ (void)registerSchemeUrl:(NSString *)urlString processBlock:(ZXMediatorProcessBlock)processBlock {
    if (urlString && processBlock) {
        // 将 block 保存到字典里
        [[[self class] mediatorCache] setObject:processBlock forKey:urlString];
    }
}

// 通过传入的 params 里面的键值对 去 mediatorcache 找关键的类然后来实现
+ (void)openUrl:(NSString *)urlString params:(NSDictionary *)params {
    ZXMediatorProcessBlock block = [[[self class] mediatorCache] objectForKey:urlString];
    if (block) {
        block(params);
    }
}

#pragma mark Protocol Class
+ (void)registerProtocol:(Protocol *)protocol class:(Class)cls {
    if (protocol && cls) {
        [[[self class] mediatorCache] setObject:cls forKey:NSStringFromProtocol(protocol)];
    }
}

+ (Class)classForProtocol:(Protocol *)protocol {
    return [[[self class] mediatorCache] objectForKey:NSStringFromProtocol(protocol)];
}

@end
