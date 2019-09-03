//
//  ZXLogin.h
//  Re0To1
//
//  Created by windorz on 2019/9/3.
//  Copyright © 2019 Q. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZXLoginFinishBlock)(BOOL isLogin);

/**
 QQ 登录和分享逻辑
 */
@interface ZXLogin : NSObject

/** 昵称 */
@property (nonatomic, strong) NSString *nick;
/** 地址 */
@property (nonatomic, strong) NSString *address;
/** 头像 URL */
@property (nonatomic, strong) NSString *avatarUrl;

+ (instancetype)sharedLogin;

#pragma mark 登录

- (BOOL)isLogin;

- (void)logInWithFinishBlock:(ZXLoginFinishBlock)finishBlock;

- (void)logOut;

#pragma mark 分享
- (void)shareToQQZoneWithArticleUrl:(NSURL *)articleUrl;

@end

NS_ASSUME_NONNULL_END
