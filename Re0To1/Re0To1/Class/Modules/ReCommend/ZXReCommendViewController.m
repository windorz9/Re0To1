//
//  ZXReCommendViewController.m
//  Re0To1
//
//  Created by windorz on 2019/8/27.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXReCommendViewController.h"

@interface ZXReCommendViewController () <UIGestureRecognizerDelegate>

@end

@implementation ZXReCommendViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon/like_selected@2x.png"];
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    
    // 创建 UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    
    NSArray *colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor]];
    
    for (int i = 0; i < 5; i++) {
        
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            view.backgroundColor = colors[i];
            view;
        })];
        
    }
    
    // 创建一个接受点击事件的视图
    UIButton *urlSchemeBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100)/2, 100, 100, 100)];
    [urlSchemeBtn setTitle:@"唤起微信" forState:UIControlStateNormal];
    [urlSchemeBtn setBackgroundColor:[UIColor orangeColor]];
    [urlSchemeBtn addTarget:self action:@selector(clickUrlSchemeBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:urlSchemeBtn];
    
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    UIButton *changeIconBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100)/2, 300, 100, 100)];
    [changeIconBtn setTitle:@"改变图标" forState:UIControlStateNormal];
    [changeIconBtn setBackgroundColor:[UIColor orangeColor]];
    [changeIconBtn addTarget:self action:@selector(clickChangeIconBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:changeIconBtn];
    
    
    
    
}

- (void)clickUrlSchemeBtn {
    
    NSLog(@"Tap");
    // 向 Scheme 白名单添加应用 , 并通过 URL 调启.
    NSURL *schemeUrl = [NSURL URLWithString:@"weixin://"];
    // 只能识别 info.plist 白名单里面的应用 LSApplicationQueriesSchemes
//    NSDictionary *options = @{
//                              UIApplicationOpenURLOptionsOpenInPlaceKey : @(0),
//                              UIApplicationOpenURLOptionsSourceApplicationKey : @"com.windorz.Re0To1"
//                              };
    __unused BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:schemeUrl];
    [[UIApplication sharedApplication] openURL:schemeUrl options:@{}
                             completionHandler:^(BOOL success) {
                                 NSLog(@"完成调启应用");
                             }];
    
}

// 改变应用的图标
- (void)clickChangeIconBtn {
    
    // 0. 首先判断是否支持改变图标
    if ([UIApplication sharedApplication].supportsAlternateIcons) {
        // 设置 nil 可以恢复到默认设置的应用图标.
        [[UIApplication sharedApplication] setAlternateIconName:@"ICONBLACK" completionHandler:^(NSError * _Nullable error) {
            NSLog(@"完成回调");
        }];
        
    }
    
}


#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return YES;
}



@end
