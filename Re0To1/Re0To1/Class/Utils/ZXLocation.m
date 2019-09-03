//
//  ZXLocation.m
//  Re0To1
//
//  Created by windorz on 2019/9/3.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface ZXLocation () <CLLocationManagerDelegate>
/** 位置信息管理者 */
@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation ZXLocation

+ (ZXLocation *)locationManager {
    static ZXLocation *location;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[ZXLocation alloc] init];
    });
    return location;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
    }
    return self;
}

#pragma mark Publick Method
// 检查当前的授权情况
- (void)checkLocationAuthorization {
    // 判断系统的总的权限开关是否开启
    if ([CLLocationManager locationServicesEnabled]) {
        // 引导弹窗, 提示用户去隐私里去开启
    }

    // 获取当前应用的位置权限
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        // 档应用的授权情况未定时 请求应用权限
        [self.manager requestWhenInUseAuthorization];
    }
}

#pragma mark CLLocationManagerDelegate
// 监听应用的权限发生改变时
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // 开始更新当前的位置
        [self.manager startUpdatingLocation];
    } else if (status == kCLAuthorizationStatusDenied) {
        // 拒绝权限的处理
    }
}

/**
 位置更更新的回调

 @param manager manager
 @param locations 地点位置
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 首先获取地理信息
    CLLocation *location = [locations firstObject];

    CLGeocoder *coder = [[CLGeocoder alloc] init];

    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError *_Nullable error) {
        NSLog(@"%@", placemarks);
    }];

    // 停止监听地理位置
    [manager stopUpdatingLocation];
}

@end
