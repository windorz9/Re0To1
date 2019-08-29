//
//  ZXListItem.h
//  Re0To1
//
//  Created by windorz on 2019/8/28.
//  Copyright © 2019 Q. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 列表模型
 */
@interface ZXListItem : NSObject
/** category */
@property(nonatomic, copy) NSString *category;
/** thumbnail_pic_s */
@property(nonatomic, copy) NSString *picUrl;
/** uniquekey */
@property(nonatomic, copy) NSString *uniquekey;
/** title */
@property(nonatomic, copy) NSString *title;
/** date */
@property(nonatomic, copy) NSString *date;
/** author */
@property(nonatomic, copy) NSString *authorName;
/** url */
@property(nonatomic, copy) NSString *ariticleUrl;

- (void)configWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
