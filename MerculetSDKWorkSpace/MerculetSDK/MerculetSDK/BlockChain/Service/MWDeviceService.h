//
//  MWDeviceService.h
//  MerculetSDK
//
//  Created by wangwei on 2018/10/30.
//  Copyright © 2018 wangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWDeviceUtil.h"
#import "MWURLRequestManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MWDeviceService : NSObject

// 发送设备信息
+ (void)updateUserInfo;

@end

NS_ASSUME_NONNULL_END
