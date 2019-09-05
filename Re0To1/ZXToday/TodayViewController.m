//
//  TodayViewController.m
//  ZXToday
//
//  Created by windorz on 2019/9/4.
//  Copyright © 2019 Q. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加一个 button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    [button setTitle:@"点击跳转" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(_openMainApp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // 添加一个 UILabel
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 50)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    // 从共享的 UserDefaults 里面获取保存的文本
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.windorz.Re0To1"];
    titleLabel.text = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"title"]];
    
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}


#pragma mark Private Method
- (void)_openMainApp {
    
    [self.extensionContext openURL:[NSURL URLWithString:@"Re0To1://"] completionHandler:^(BOOL success) {
        NSLog(@"成功跳转到主 App");
    }];
    
}

@end
