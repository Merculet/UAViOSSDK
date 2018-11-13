//
//  MWURLService.m
//  MerculetSDK
//
//  Created by wangwei on 2018/10/24.
//  Copyright © 2018 wangwei. All rights reserved.
//

#import "MWURLService.h"
#import "MerculetDefine.h"

@implementation MWURLService

+ (NSString *)urlDomain {
//    return MW_RELEASE_API;
    return @"";
}

+ (NSString *)urlTrackingURL {
    return  MW_TRACKING_URL;
}

+ (NSString *)urlDeviceURL {
    return  MW_DEVICE_API;
}


@end
