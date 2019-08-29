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
    
    // 测试文件写入和查询
    [self getSandBoxPath];
    
}

- (void)getSandBoxPath {
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    
    // 使用 NSFileManager 创建文件和文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 创建文件夹
    NSString *dataDirectoryPath = [cachePath stringByAppendingPathComponent:@"ZXData"];
    NSError *creatDirectoryError;
    [fileManager createDirectoryAtPath:dataDirectoryPath withIntermediateDirectories:YES attributes:nil error:&creatDirectoryError];
    
    // 创建文件 同时写入文件
    NSString *listDataPath = [dataDirectoryPath stringByAppendingPathComponent:@"list"];
    NSData *listData = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    
    // 判断文件是否存在
    BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];
    
//    if (fileExist) {
//        [fileManager removeItemAtPath:fileExist error:nil];
//    }
    
    // 使用 NSFileHandle 进行文件的修改
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
    [fileHandle seekToEndOfFile];
    
    [fileHandle writeData:[@"def" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle synchronizeFile];
    [fileHandle closeFile];
    
    NSLog(@"");
    
    
}

@end
