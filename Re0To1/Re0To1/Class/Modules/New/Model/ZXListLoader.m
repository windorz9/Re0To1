//
//  ZXListLoader.m
//  Re0To1
//
//  Created by windorz on 2019/8/28.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXListLoader.h"
#import <AFNetworking.h>
#import "ZXListItem.h"

@implementation ZXListLoader

- (void)loadListDataWithFinishBlock:(ZXlistLoaderFinishBlock)finishBlock {
    
    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listUrl = [NSURL URLWithString:urlString];
    
    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listUrl];
    
//     封装成 task
    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:listRequest];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listUrl
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                // 解析返回的二进制数据
                                                NSError *jsonError;
                                                id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
#warning 类型检查
                                                // 解析 json 获取数据
                                                NSArray *dataArray = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
                                                
                                                NSMutableArray *listItemArray = @[].mutableCopy;
                                                for (NSDictionary *info in dataArray) {
                                                    ZXListItem *item = [[ZXListItem alloc] init];
                                                    [item configWithDictionary:info];
                                                    [listItemArray addObject:item];
                                                }
                                                dispatch_async(dispatch_get_main_queue()
                                                               , ^{
                                                                   // 将数据通过 block 传出
                                                                   if (finishBlock) {
                                                                       finishBlock(error == nil, listItemArray.copy);
                                                                   }
                                                               });                                                
                                            }];
    [dataTask resume];
    
//    [[AFHTTPSessionManager manager] GET:@"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e" parameters:nil
//                               progress:^(NSProgress * _Nonnull downloadProgress) {
//
//                               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                   NSLog(@"");
//                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                   NSLog(@"");
//                               }];
    
}

@end
