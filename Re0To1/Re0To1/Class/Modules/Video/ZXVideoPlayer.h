//
//  ZXVideoPlayer.h
//  Re0To1
//
//  Created by windorz on 2019/8/29.
//  Copyright © 2019 Q. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 播放器单例
 */
@interface ZXVideoPlayer : NSObject

+ (ZXVideoPlayer *)player;

- (void)playVideoWithVideoUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
