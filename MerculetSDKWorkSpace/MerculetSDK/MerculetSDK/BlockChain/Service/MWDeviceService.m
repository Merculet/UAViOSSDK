//
//  MWDeviceService.m
//  MerculetSDK
//
//  Created by wangwei on 2018/10/30.
//  Copyright © 2018 wangwei. All rights reserved.
//

#import "MWDeviceService.h"
#import "MWURLRequestManager.h"
#import "MWCommonService.h"
#import "MWCommonUtil.h"
#import "MWDeviceUtil.h"
#import "MerculetDefine.h"
#import "MWCommonService.h"
#import "MWCommonUtil.h"
#import "MWPostServiceKey.h"

@implementation MWDeviceService

// 发送设备信息
+ (void)updateUserInfo {
    
    // 判断用户是否登录
    NSString *token = [[MWCommonService sharedInstance] getMWToken];
    if ([MWCommonUtil isBlank:token]) {return;}
    
    // 判断是否上传过设备信息
//    BOOL hasUpdate = [[MWCommonService sharedInstance] isUpdateDevice];
//    if (hasUpdate) {return;}
    
    
    // 拼接设备信息
    MWDeviceUtil *device = [[MWDeviceUtil alloc] init];
    NSDictionary *deviceInfo = [device getAllDevice];
    
    
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    if ([MWCommonUtil isNotBlank:token]) {
        [headers setValue:token forKey:MW_POST_KEY_EVENT_MW_TOKEN]; // 设置token
        [[[MWURLRequestManager alloc] init] POST:MW_DEVICE_API headers:headers parameters:deviceInfo success:^(NSURLResponse *response, id responseObject, NSData *data) {
            [[MWCommonService sharedInstance] updateDevice];
        } failure:^(NSURLResponse *response, NSError *error) {
            
        }];
    } else {
    }
    
   
    
}

@end
