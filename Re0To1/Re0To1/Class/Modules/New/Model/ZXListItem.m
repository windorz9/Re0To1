//
//  ZXListItem.m
//  Re0To1
//
//  Created by windorz on 2019/8/28.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXListItem.h"

@implementation ZXListItem

#pragma mark NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        // 解档
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.picUrl = [aDecoder decodeObjectForKey:@"picUrl"];
        self.uniquekey = [aDecoder decodeObjectForKey:@"uniquekey"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.authorName = [aDecoder decodeObjectForKey:@"authorName"];
        self.ariticleUrl = [aDecoder decodeObjectForKey:@"ariticleUrl"];
        
    }
    return self;
}

// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.picUrl forKey:@"picUrl"];
    [aCoder encodeObject:self.uniquekey forKey:@"uniquekey"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.authorName forKey:@"authorName"];
    [aCoder encodeObject:self.ariticleUrl forKey:@"ariticleUrl"];
    
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark Public Mathod
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
