//
//  ZXLogin.m
//  Re0To1
//
//  Created by windorz on 2019/9/3.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXLogin.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface ZXLogin () <TencentSessionDelegate>
/** 验证 */
@property (nonatomic, strong) TencentOAuth *oauth;
/** 完成回调 */
@property (nonatomic, copy) ZXLoginFinishBlock finishBlock;
/** 登录状态 */
@property (nonatomic, assign) BOOL isLogin;
@end

@implementation ZXLogin

+ (instancetype)sharedLogin {
    static ZXLogin *login;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[ZXLogin alloc] init];
    });
    return login;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isLogin = NO;
        _oauth = [[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:self];
    }
    return self;
}

- (BOOL)isLogin {
    // 还需要添加邓肯失效的逻辑
    return _isLogin;
}

- (void)logInWithFinishBlock:(ZXLoginFinishBlock)finishBlock {
    _finishBlock = finishBlock;

    _oauth.authMode = kAuthModeClientSideToken;
    [_oauth authorize:@[
         kOPEN_PERMISSION_GET_USER_INFO,
         kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
         kOPEN_PERMISSION_ADD_ALBUM,
         kOPEN_PERMISSION_ADD_ONE_BLOG,
         kOPEN_PERMISSION_ADD_SHARE,
         kOPEN_PERMISSION_ADD_TOPIC,
         kOPEN_PERMISSION_CHECK_PAGE_FANS,
         kOPEN_PERMISSION_GET_INFO,
         kOPEN_PERMISSION_GET_OTHER_INFO,
         kOPEN_PERMISSION_LIST_ALBUM,
         kOPEN_PERMISSION_UPLOAD_PIC,
         kOPEN_PERMISSION_GET_VIP_INFO,
         kOPEN_PERMISSION_GET_VIP_RICH_INFO
    ]];
}

- (void)logOut {
    [_oauth logout:self];
    _isLogin = NO;
}

#pragma mark TencentSessionDelegate
/**
 登录成功的回调
 */
- (void)tencentDidLogin {
    _isLogin = YES;
    // 还需保存 Openid
    [_oauth getUserInfo];
}

/**
 登录失败的回调

 @param cancelled 代表用户是否是主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (_finishBlock) {
        _finishBlock(NO);
    }
}

/**
 登录时网络状态有问题
 */
- (void)tencentDidNotNetWork {
}

/**
 退出登录时的回调
 */
- (void)tencentDidLogout {
    // 退出登录, 需要清理下存储在本地的数据
}

/**
 获取个人信息的回调

 @param response 返回用户的信息
 */
- (void)getUserInfoResponse:(APIResponse *)response {
    NSDictionary *userInfo = response.jsonResponse;
    _nick = userInfo[@"nickname"];
    _address = userInfo[@"city"];
    _avatarUrl = userInfo[@"figureurl_qq_2"];
    if (_finishBlock) {
        _finishBlock(YES);
    }
}

#pragma mark 分享
- (void)shareToQQZoneWithArticleUrl:(NSURL *)articleUrl {
    // 首先需要进行登录的校验

    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:articleUrl title:@"iOS" description:@"从 0 开始" previewImageURL:nil];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    __unused QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
}

@end
