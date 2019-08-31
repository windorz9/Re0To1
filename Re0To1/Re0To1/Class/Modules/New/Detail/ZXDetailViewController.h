//
//  ZXDetailViewController.h
//  Re0To1
//
//  Created by windorz on 2019/8/27.
//  Copyright © 2019 Q. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXMediator.h"

NS_ASSUME_NONNULL_BEGIN


/**
 文章底层页
 */
@interface ZXDetailViewController : UIViewController <ZXDetailViewControllerProtocol>

- (instancetype)initWithUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
