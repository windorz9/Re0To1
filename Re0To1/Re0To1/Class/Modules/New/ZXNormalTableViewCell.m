//
//  ZXNormalTableViewCell.m
//  Re0To1
//
//  Created by windorz on 2019/8/27.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXNormalTableViewCell.h"

@interface ZXNormalTableViewCell ()

/** title */
@property(nonatomic, strong) UILabel *titleLabel;
/** source */
@property(nonatomic, strong) UILabel *sourceLabel;
/** comment */
@property(nonatomic, strong) UILabel *commentLabel;
/** time */
@property(nonatomic, strong) UILabel *timeLabel;
/** image */
@property(nonatomic, strong) UIImageView *rightImageView;
/** delete */
@property(nonatomic, strong) UIButton *deleteBtn;


@end

@implementation ZXNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 创建对应的 label
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 250, 50)];
//        self.titleLabel.backgroundColor = [UIColor redColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 20)];
//        self.sourceLabel.backgroundColor = [UIColor redColor];
        self.sourceLabel.font = [UIFont systemFontOfSize:12];;
        self.sourceLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.sourceLabel];
        
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 50, 20)];
//        self.commentLabel.backgroundColor = [UIColor redColor];
        self.commentLabel.font = [UIFont systemFontOfSize:12];
        self.commentLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.commentLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 50, 20)];
//        self.timeLabel.backgroundColor = [UIColor redColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.timeLabel];
        
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 15, 70, 70)];
        self.rightImageView.backgroundColor = [UIColor redColor];
        self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.rightImageView];
        
        self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(240, 80, 30, 20)];
        [self.deleteBtn setTitle:@"X" forState:UIControlStateNormal];
        [self.deleteBtn setTitle:@"V" forState:UIControlStateHighlighted];
        [self.deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.deleteBtn.layer.cornerRadius = 10;
        self.deleteBtn.layer.masksToBounds = YES;
        self.deleteBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.deleteBtn.layer.borderWidth = 2.0;
        [self.deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteBtn];
        
        
    }
    return self;
    
    
}


// 设置内容和修改文本位置
- (void)layoutTableViewCell {
    
    self.titleLabel.text = @"皮皮虾,我们走";
    
    self.sourceLabel.text = @"github";
    [self.sourceLabel sizeToFit];
    
    self.commentLabel.text = @"1888评论";
    [self.commentLabel sizeToFit];
    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);
    
    self.timeLabel.text = @"1小时前";
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + 15, self.timeLabel.frame.origin.y, self.timeLabel.bounds.size.width, self.timeLabel.bounds.size.height);
    
    self.rightImageView.image = [UIImage imageNamed:@"icon.bundle/time.jpeg"];
    
}


- (void)deleteBtnClicked {
    
    // 首先将代理事件传出
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeleteBtn:)]) {
        [self.delegate tableViewCell:self clickDeleteBtn:self.deleteBtn];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    if (selected) {
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundColor = [UIColor blueColor];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.backgroundColor = [UIColor whiteColor];
                             }];
        }];
    }
}


@end
