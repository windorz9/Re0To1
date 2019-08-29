//
//  ZXListLoader.h
//  Re0To1
//
//  Created by windorz on 2019/8/28.
//  Copyright © 2019 Q. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXListItem;

typedef void(^ZXlistLoaderFinishBlock)(BOOL success, NSArray<ZXListItem *> *dataArray);
/**
 网络请求类
 */
@interface ZXListLoader : NSObject

- (void)loadListDataWithFinishBlock:(ZXlistLoaderFinishBlock)finishBlock;

@end

