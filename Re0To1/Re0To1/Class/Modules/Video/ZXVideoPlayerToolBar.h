//
//  ZXVideoPlayerToolBar.h
//  Re0To1
//
//  Created by windorz on 2019/8/30.
//  Copyright © 2019 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZXVideoPlayerToolBarHeight 60

@interface ZXVideoPlayerToolBar : UIView

// 供外界传入数据 对 toolbar 进行数据修改
- (void)layoutWithModel:(id)model;


@end

