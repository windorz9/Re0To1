//
//  ZXSplashView.m
//  Re0To1
//
//  Created by windorz on 2019/8/30.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXSplashView.h"
#import "ZXScreen.h"

@implementation ZXSplashView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // 为自身设置图片 并添加跳过按钮
        self.image = [UIImage imageNamed:@"icon.bundle/splashImage.jpg"];
        self.userInteractionEnabled = YES;
        
        UIButton *skipBtn = [[UIButton alloc] initWithFrame:UIRect(300, 100, 60, 40)];
        [self addSubview:skipBtn];
        skipBtn.backgroundColor = [UIColor lightGrayColor];
        [skipBtn setTitle:@"跳 过" forState:UIControlStateNormal];
        [skipBtn addTarget:self action:@selector(_clickSkipBtn) forControlEvents:UIControlEventTouchUpInside];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self _clickSkipBtn];
        });
        
    }
    return self;
    
}

#pragma mark Private Method
- (void)_clickSkipBtn {
    [self removeFromSuperview];
}


@end
