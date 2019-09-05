//
//  ZXCommentManager.h
//  Re0To1
//
//  Created by windorz on 2019/9/4.
//  Copyright © 2019 Q. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXCommentManager : NSObject

+ (ZXCommentManager *)sharedManager;


/**
 展示视图
 */
- (void)showCommentView;

@end


