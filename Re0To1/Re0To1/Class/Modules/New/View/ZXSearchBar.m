//
//  ZXSearchBar.m
//  Re0To1
//
//  Created by windorz on 2019/9/4.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXSearchBar.h"
#import "ZXScreen.h"

@interface ZXSearchBar () <UITextFieldDelegate>

@end

@implementation ZXSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建一个 UITextField
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(UI(10), UI(5), self.bounds.size.width - UI(10) * 2, self.bounds.size.height - UI(5) * 2)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.delegate = self;
        [self addSubview:textField];

        UIImageView *leftImaegView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        leftImaegView.contentMode = UIViewContentModeCenter;
        leftImaegView.image = [UIImage imageNamed:@"search"];
        textField.leftView = leftImaegView;
        textField.leftViewMode = UITextFieldViewModeUnlessEditing;

        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        textField.placeholder = @"热点新闻推荐";
    
    }
    return self;
}

#pragma mark UITextFieldDelegate
// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    NSLog(@"开始编辑");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSLog(@"结束编辑");
}

// 改变文本
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSLog(@"内容改变");
    return YES;
}

// 点击 return 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
