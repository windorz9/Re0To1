//
//  ZXNormalTableViewCell.h
//  Re0To1
//
//  Created by windorz on 2019/8/27.
//  Copyright © 2019 Q. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXListItem;

@protocol ZXNormalTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteBtn:(UIButton *)deleteBtn;

@end

@interface ZXNormalTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ZXNormalTableViewCellDelegate> delegate;

- (void)layoutTableViewCellWithItem:(ZXListItem *)item;

@end

