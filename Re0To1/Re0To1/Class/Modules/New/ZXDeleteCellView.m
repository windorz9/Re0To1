//
//  ZXDeleteCellView.m
//  Re0To1
//
//  Created by windorz on 2019/8/28.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXDeleteCellView.h"

@interface ZXDeleteCellView ()
/** 背景视图 */
@property(nonatomic, strong) UIView *backgroundView;
/** 删除 button */
@property(nonatomic, strong) UIButton *deleteBtn;
/** blcok */
@property(nonatomic, copy) dispatch_block_t deleteBlock;

@end

@implementation ZXDeleteCellView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // 添加到视图上
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.5;
        self.backgroundView = backgroundView;
        [self addSubview:backgroundView];
        
        // 添加一个单击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteView)];
        [backgroundView addGestureRecognizer:tap];
    
        
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        deleteBtn.backgroundColor = [UIColor blueColor];
        [deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn = deleteBtn;
        [self addSubview:deleteBtn];
        
    }
    return self;

}

// 点击删除按钮
- (void)clickDeleteBtn {
    if (_deleteBlock) {
        _deleteBlock();
    }
    [self removeFromSuperview];
    
}


// 添加到 window 上
- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock {
    
    self.deleteBtn.frame = CGRectMake(point.x, point.y, 0, 0);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    _deleteBlock = [clickBlock copy];
    // 添加一个动画
//    [UIView animateWithDuration:1.f animations:^{
//        self.deleteBtn.frame = CGRectMake((self.bounds.size.width - 200)/2, (self.bounds.size.height - 200)/2, 200, 200);
//    }];
    
    [UIView animateWithDuration:1.f delay:0.f
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.deleteBtn.frame = CGRectMake((self.bounds.size.width - 200)/2, (self.bounds.size.height - 200)/2, 200, 200);
                     } completion:^(BOOL finished) {
                         NSLog(@"动画完成");
                     }];
    
    
    
}

- (void)dismissDeleteView {
    
    [self removeFromSuperview];
    
}


@end
