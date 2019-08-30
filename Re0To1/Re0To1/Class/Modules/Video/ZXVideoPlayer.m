//
//  ZXVideoPlayer.m
//  Re0To1
//
//  Created by windorz on 2019/8/29.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface ZXVideoPlayer ()
/** AVPlayerItem */
@property (nonatomic, strong) AVPlayerItem *playerItem;
/** AVPlayer */
@property (nonatomic, strong) AVPlayer *player;
/** AVPlayerLayer */
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/** timeObserver */
@property (nonatomic, strong) id timerObserver;

@end

@implementation ZXVideoPlayer

+ (ZXVideoPlayer *)player {
    static ZXVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[ZXVideoPlayer alloc] init];
    });
    return player;
}

- (void)playVideoWithVideoUrl:(NSString *)videoUrl attachView:(UIView *)attachView {
    [self _stopPlay];

    // 单击播放指定的视频
    AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:videoUrl]];
    _playerItem = [AVPlayerItem playerItemWithAsset:asset];

    // 监听当前的 AVPlayerItem 的状态是否满足播放
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 监听从网络加载时的一个缓冲进度
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    // 获取当前视频的时长 必须等待视频加载完毕才行
    //    CMTime duration = _playerItem.duration;
    //    CGFloat videoDuration = CMTimeGetSeconds(duration);
    //    NSLog(@"视频的时长为 %f", videoDuration);

    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    // 监听播放器的播放时长 1s 监听一次
    _timerObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度 %f", CMTimeGetSeconds(time));
    }];

    //    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:_videoUrl]];

    // 获取视频播放的 layery
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = attachView.bounds;
    [attachView.layer addSublayer:_playerLayer];

    // 添加通知中心监听播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

    //    [_player play];
}

- (void)_stopPlay {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    // 停止播放
    [_player removeTimeObserver:_timerObserver];
    [_playerLayer removeFromSuperlayer];
    _timerObserver = nil;
    _playerItem = nil;
    _player = nil;
}

- (void)_handlePlayEnd {
    NSLog(@"播放结束");
    // 循环播放
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        // 确定监听的是当前的播放状态
        if ([(NSNumber *)[change objectForKey:NSKeyValueChangeNewKey] integerValue] == AVPlayerStatusReadyToPlay) {
            [_player play];
            // 准备播放时才能获取到视频的时长
            CMTime duration = _playerItem.duration;
            CGFloat videoDuration = CMTimeGetSeconds(duration);
            NSLog(@"视频的时长为 %f", videoDuration);
        } else {
            NSLog(@"未准备好播放");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"缓冲进度 : %@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}

@end
