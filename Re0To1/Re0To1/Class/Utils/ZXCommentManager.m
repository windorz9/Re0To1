//
//  ZXCommentManager.m
//  Re0To1
//
//  Created by windorz on 2019/9/4.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXCommentManager.h"
#import <UIKit/UIKit.h>
#import "ZXScreen.h"

@interface ZXCommentManager () <UITextViewDelegate>
/** 背景视图 */
@property (nonatomic, strong) UIView *backgroundView;
/** TextView */
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ZXCommentManager

+ (ZXCommentManager *)sharedManager {
    
    static ZXCommentManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZXCommentManager alloc] init];
    });
    return instance;
    
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        // 创建内部的视图
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        // 添加一个单击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTapGesture)];
        [_backgroundView addGestureRecognizer:tap];
        
        // 添加 TextView
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, _backgroundView.bounds.size.height, SCREEN_WIDTH, UI(100))];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.borderWidth = 5.0;
        _textView.delegate = self;
        [_backgroundView addSubview:_textView];
        
        // 监听键盘的一个 frame 变化来改变我们的文本框的位置
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handleKeyboardFrameChangeNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    return self;
}

#pragma mark Public Methdo
- (void)showCommentView {
    
    [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
    [_textView becomeFirstResponder];
}


#pragma mark Private Method
- (void)_handleTapGesture {
    
    [_textView resignFirstResponder];
    [_backgroundView removeFromSuperview];
    

}

// 接收到键盘的 frame 改变的通知
- (void)_handleKeyboardFrameChangeNotification:(NSNotification *)notification {
    
    NSLog(@"%@", notification);
    // 获取键盘弹出的动画时间和最终键盘位置的 frame
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (keyboardFrame.origin.y >= SCREEN_HEIGHT) {
        // 收起
        [UIView animateWithDuration:duration
                         animations:^{
                             self.textView.frame = CGRectMake(0, self.backgroundView.bounds.size.height, SCREEN_WIDTH, UI(100));
                         }];
    } else {
        // 弹出
        self.textView.frame = CGRectMake(0, self.backgroundView.bounds.size.height, SCREEN_WIDTH, UI(100));
        [UIView animateWithDuration:duration
                         animations:^{
                             self.textView.frame = CGRectMake(0, keyboardFrame.origin.y - UI(100), SCREEN_WIDTH, UI(100));
                         }];
    }
    
}



- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
