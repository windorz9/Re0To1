//
//  ZXVideoPlayerToolBar.m
//  Re0To1
//
//  Created by windorz on 2019/8/30.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXVideoPlayerToolBar.h"

@interface ZXVideoPlayerToolBar ()
/** avatorImageView */
@property (nonatomic, strong) UIImageView *avatorImageView;
/** nickLabel */
@property (nonatomic, strong) UILabel *nickLabel;
/** commentImageView */
@property (nonatomic, strong) UIImageView *commentImageView;
/** commentLabel */
@property (nonatomic, strong) UILabel *commentLabel;
/** likeImageView */
@property (nonatomic, strong) UIImageView *likeImageView;
/** likeLabel */
@property (nonatomic, strong) UILabel *likeLabel;
/** shareImageView */
@property (nonatomic, strong) UIImageView *shareImageView;
/** shareLabel */
@property (nonatomic, strong) UILabel *shareLabel;

@end

@implementation ZXVideoPlayerToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 添加八个内容子视图
        UIImageView *avatorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        avatorImageView.layer.masksToBounds = YES;
        avatorImageView.layer.cornerRadius = 15;
        avatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:avatorImageView];
        self.avatorImageView = avatorImageView;

        UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nickLabel.font = [UIFont systemFontOfSize:15];
        nickLabel.textColor = [UIColor lightGrayColor];
        nickLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:nickLabel];
        self.nickLabel = nickLabel;

        UIImageView *commentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        commentImageView.layer.masksToBounds = YES;
        commentImageView.layer.cornerRadius = 15;
        commentImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:commentImageView];
        self.commentImageView = commentImageView;

        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        commentLabel.font = [UIFont systemFontOfSize:15];
        commentLabel.textColor = [UIColor lightGrayColor];
        commentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:commentLabel];
        self.commentLabel = commentLabel;

        UIImageView *likeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        likeImageView.layer.masksToBounds = YES;
        likeImageView.layer.cornerRadius = 15;
        likeImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:likeImageView];
        self.likeImageView = likeImageView;

        UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        likeLabel.font = [UIFont systemFontOfSize:15];
        likeLabel.textColor = [UIColor lightGrayColor];
        likeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:likeLabel];
        self.likeLabel = likeLabel;

        UIImageView *shareImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        shareImageView.layer.masksToBounds = YES;
        shareImageView.layer.cornerRadius = 15;
        shareImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:shareImageView];
        self.shareImageView = shareImageView;

        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        shareLabel.font = [UIFont systemFontOfSize:15];
        shareLabel.textColor = [UIColor lightGrayColor];
        shareLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:shareLabel];
        self.shareLabel = shareLabel;
    }
    return self;
}


// 对整个界面进行布局
- (void)layoutWithModel:(id)model {
    
    _avatorImageView.image = [UIImage imageNamed:@"icon.bundle/icon.png"];
    _nickLabel.text = @"皮皮虾";
    
    _commentImageView.image = [UIImage imageNamed:@"comment"];
    _commentLabel.text = @"100";
    
    _likeImageView.image = [UIImage imageNamed:@"praise"];
    _likeLabel.text = @"25";
    
    _shareImageView.image = [UIImage imageNamed:@"share"];
    _shareLabel.text = @"分享";
    
    // 进行自动布局
    [NSLayoutConstraint activateConstraints:@[
                                              [NSLayoutConstraint constraintWithItem:_avatorImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],
                                              [NSLayoutConstraint constraintWithItem:_avatorImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:15],
                                              [NSLayoutConstraint constraintWithItem:_avatorImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30],
                                              [NSLayoutConstraint constraintWithItem:_avatorImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30],
                                              
                                              [NSLayoutConstraint constraintWithItem:_nickLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatorImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],
                                              
                                              [NSLayoutConstraint constraintWithItem:_nickLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_avatorImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]
                                              
                                              ]];
    
    
    // 使用 VFL 实现接下来的 6个布局
    NSString *vflString = @"H:|-15-[_avatorImageView]-0-[_nickLabel]-(>=0)-[_commentImageView(==_avatorImageView)]-0-[_commentLabel]-15-[_likeImageView(==_avatorImageView)]-0-[_likeLabel]-15-[_shareImageView(==_avatorImageView)]-0-[_shareLabel]-15-|";
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflString options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_avatorImageView, _nickLabel, _commentImageView, _commentLabel, _likeImageView, _likeLabel, _shareImageView, _shareLabel)]];
    
    
    
}

@end
