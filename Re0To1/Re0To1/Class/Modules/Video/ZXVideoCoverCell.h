//
//  ZXVideoCoverCell.h
//  Re0To1
//
//  Created by windorz on 2019/8/29.
//  Copyright © 2019 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXVideoCoverCell : UICollectionViewCell

// 从外界传出一个图片和一个视频链接
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoURl;


@end

NS_ASSUME_NONNULL_END
