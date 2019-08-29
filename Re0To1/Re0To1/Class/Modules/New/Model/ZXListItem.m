//
//  ZXListItem.m
//  Re0To1
//
//  Created by windorz on 2019/8/28.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXListItem.h"

@implementation ZXListItem

- (void)configWithDictionary:(NSDictionary *)dic {
    
#warning 类型检查
    self.category = [dic objectForKey:@"category"];
    self.picUrl = [dic objectForKey:@"thumbnail_pic_s"];
    self.uniquekey = [dic objectForKey:@"uniquekey"];
    self.title = [dic objectForKey:@"title"];
    self.date = [dic objectForKey:@"date"];
    self.authorName = [dic objectForKey:@"author_name"];
    self.ariticleUrl = [dic objectForKey:@"url"];
        
}

@end
