//
//  ZXVideoCoverCell.m
//  Re0To1
//
//  Created by windorz on 2019/8/29.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXVideoCoverCell.h"
#import <AVFoundation/AVFoundation.h>
#import "ZXVideoPlayer.h"
#import "ZXVideoPlayerToolBar.h"

@interface ZXVideoCoverCell ()
/** 首帧展示视图 */
@property (nonatomic, strong) UIImageView *coverView;
/** 播放图片 */
@property (nonatomic, strong) UIImageView *playerView;
/** 保存一个视频链接 */
@property (nonatomic, copy) NSString *videoUrl;
/** 底部的 ToolBar */
@property (nonatomic, strong) ZXVideoPlayerToolBar *toolBar;

@end

@implementation ZXVideoCoverCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 创建一个显示第一帧的视图以及一个播放视图
        UIImageView *coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - ZXVideoPlayerToolBarHeight)];
        self.coverView = coverView;
        [self.contentView addSubview:coverView];

        UIImageView *playView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 50) / 2, (self.bounds.size.height - ZXVideoPlayerToolBarHeight - 50) / 2, 50, 50)];
        playView.image = [UIImage imageNamed:@"icon.bundle/videoPlay@3x.png"];
        self.playerView = playView;
        [coverView addSubview:playView];
        
        ZXVideoPlayerToolBar *toolBar = [[ZXVideoPlayerToolBar alloc] initWithFrame:CGRectMake(0, coverView.bounds.size.height, frame.size.width, ZXVideoPlayerToolBarHeight)];
        self.toolBar = toolBar;
        [self.contentView addSubview:toolBar];

        // 添加一个全范围的单击事件来控制视频的播放, 当然也可以通过 UICollectionView 的 didSeletc
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

#pragma mark Public Method
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoURl {
    // 假数据
    _videoUrl = videoURl;
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    [_toolBar layoutWithModel:nil];
}

#pragma mark Private Method
- (void)_tapToPlay {

    [[ZXVideoPlayer player] playVideoWithVideoUrl:_videoUrl attachView:_coverView];
}



@end
