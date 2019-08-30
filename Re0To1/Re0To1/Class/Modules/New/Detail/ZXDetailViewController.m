//
//  ZXDetailViewController.m
//  Re0To1
//
//  Created by windorz on 2019/8/27.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXDetailViewController.h"
#import <WebKit/WebKit.h>
#import "ZXScreen.h"

@interface ZXDetailViewController () <WKNavigationDelegate>
/** WebView */
@property(nonatomic, strong) WKWebView *webView;
/** 加载进度条 */
@property(nonatomic, strong) UIProgressView *progressView;
/** 文章字符串 */
@property(nonatomic, copy) NSString *articleUrl;

@end

@implementation ZXDetailViewController

- (instancetype)initWithUrlString:(NSString *)urlString {
    
    self = [super init];
    if (self) {
        self.articleUrl = urlString;
    }
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建 WKWebView 进行加载页面
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.bounds.size.width, self.view.bounds.size.height - STATUSBARHEIGHT - 44)];
    webView.navigationDelegate = self;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.articleUrl]];
    [webView loadRequest:request];
    self.webView = webView;
    [self.view addSubview:webView];
    
    // 添加 KVO 监听当前页面的加载进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    // 创建一个自定义的加载进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.bounds.size.width, 2)];
    self.progressView = progressView;
    [self.view addSubview:progressView];
}


#pragma mark <##>WKNavigationDelegate
// 是否决定加载某个页面
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    // 允许加载
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"加载完成");
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"加载失败 error:%@", error);
    
}


#pragma mark KVO 回调
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    
    self.progressView.progress = [change[NSKeyValueChangeNewKey] floatValue];
    
}


- (void)dealloc {
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}




@end
