//
//  ZXScreen.h
//  Re0To1
//
//  Created by windorz on 2019/8/30.
//  Copyright © 2019 Q. All rights reserved.
//

#import <UIKit/UIKit.h>

// 判断是否是横屏
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
// 获取屏幕宽高
#define SCREEN_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

// 判断是不是刘海屏
#define IS_IPHONE_X (SCREEN_WIDTH == [ZXScreen sizeFor58Inch].width && SCREEN_HEIGHT == [ZXScreen sizeFor58Inch].height)
#define IS_IPHONE_XR (SCREEN_WIDTH == [ZXScreen sizeFor61Inch].width && SCREEN_HEIGHT == [ZXScreen sizeFor61Inch].height && [UIScreen mainScreen].scale == 2)
#define IS_IPHONE_XS_MAX (SCREEN_WIDTH == [ZXScreen sizeFor65Inch].width && SCREEN_HEIGHT == [ZXScreen sizeFor65Inch].height && [UIScreen mainScreen].scale == 3)

#define IS_IPHONE_X_XR_MAX (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XS_MAX)
#define STATUSBARHEIGHT (IS_IPHONE_X_XR_MAX ? 44 : 20)

#define UI(x) UIAdapter(x)
#define UIRect(x, y, width, height) UIRectAdapter(x, y, width, height)

// 创建几个内联函数
static inline NSInteger UIAdapter (float x) {
    // 1.分机型进行适配
    
    
    // 2.物理分辨率尺寸进行适配
    CGFloat scale = 375 / SCREEN_WIDTH;
    return (NSInteger)x / scale;
    
}

static inline CGRect UIRectAdapter(x, y, width, height) {
    
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
 
}


@interface ZXScreen : NSObject

// iPhone XS max
+ (CGSize)sizeFor65Inch;
// iPhone XR
+ (CGSize)sizeFor61Inch;
// iPhone X XS
+ (CGSize)sizeFor58Inch;

@end


