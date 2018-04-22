 //
//  MWCompositeEvent.m
//
//
//  Created by 刘家飞 on 15/1/10.
//  Copyright (c) 2015年 All rights reserved.
//

#import "MWCompositeEvent.h"
//#import "MWNSStringUtils.h"
#import "MWDeviceUtil.h"
#import "MWCommonUtil.h"
#import "MWDictionaryUtils.h"
//#import "MWCommonService.h"
//#import "MWGeo.h"
#import "MWDictionaryUtils.h"
//#import "MWSessionManager.h"
//#import "MWUserProfileConfig.h"
//#import "MWAppInfo.h"
#import "MWTrackingDefine.h"
#import "MWCommonService.h"
#import "MWDictionaryUtils.h"
#import "MWNSStringUtils.h"
#import "MWLog.h"
#import <UIKit/UIKit.h>


@implementation MWCompositeEvent


- (NSDictionary *)getCompositeEventDicWithEvents:(NSArray *)events
{
    
    @try {
        if ([MWCommonUtil isBlank:events])
        {
            return nil;
        }
//        MWAppInfo *appInfo = [[MWAppInfo alloc] init];
        NSDictionary *dic = @{
                              MW_POST_KEY_EVENT_app_key:Value([[MWCommonService sharedInstance] getAppKey]),
                              MW_POST_KEY_EVENT_external_user_id:Value([[MWCommonService sharedInstance] getuserOpenid]),
                              MW_POST_KEY_EVENT_device_info:Value_class([MWDeviceUtil getIDFA]),
                              MW_POST_KEY_EVENT_actions:events
                              };

//        NSMutableDictionary *eventDic = [NSMutableDictionary dictionaryWithDictionary:[appInfo getAppInfo]];
//        [eventDic setValuesForKeysWithDictionary:dic];

        return [MWDictionaryUtils reviewDic:dic];
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"getCompositeEventDicWithEvents:"];
    } @finally {

    }
}

- (NSDictionary *)getDeviceDic
{
//    @try {
//        MWDeviceUtil *device = [[MWDeviceUtil alloc] init];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[device getDevice]];
//        [dic setObject:Value_class([device getCarrier]) forKey:MW_POST_KEY_DEVICE_CARRIER];
//        [dic setObject:Value_class([[MWCommonService sharedInstance] appFirstStartTime]) forKey:MW_POST_KEY_DEVICE_FIRST_TIME];
//        [dic setObject:@1 forKey:MW_POST_KEY_DEVICE_FIRST_LAUNCH];
//
//        return dic;
//    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"getDeviceDic"];
//    } @finally {
//
//    }
    return nil;
}

+ (NSDictionary *)getLoginToken {
    
//    [MWLog logForDev:@"当前线程：%@",[]]
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
//    });
   
    NSString *app_key = [[MWCommonService sharedInstance] getAppKey];
    NSString *account_key = [[MWCommonService sharedInstance] getAccountKey];
    NSString *account_secret = [[MWCommonService sharedInstance] getAccountSecret];
    NSString *invitation_code = [[MWCommonService sharedInstance] getInvitationCode];
    NSString *user_open_id = [[MWCommonService sharedInstance] getuserOpenid];
    NSInteger timestamp1 = (NSInteger)([[NSDate date] timeIntervalSince1970] * 1000);
    NSInteger nonce = [MWNSStringUtils createRandomNum].integerValue;
    
    NSString *timestampStr = [NSString stringWithFormat:@"%ld",(long)timestamp1];// 毫秒事件
    NSString *nonceStr = [NSString stringWithFormat:@"%ld",(long)nonce];
    
    NSMutableString *sign = [NSMutableString string];
    [sign appendString:Value(account_key)];
    [sign appendString:Value(app_key)];
    [sign appendString:Value(invitation_code)];
    [sign appendString:Value(nonceStr)];
    [sign appendString:Value(timestampStr)];
    [sign appendString:Value(user_open_id)];
    [sign appendString:Value(account_secret)];
    
    // 加密
    NSString *signComp = [MWNSStringUtils MD5TO32Lower:sign];
    
    NSDictionary *dic = @{
                          MW_POST_KEY_app_key:Value(app_key),
                          MW_POST_KEY_account_key:Value(account_key),
//                          MW_POST_KEY_account_secret:Value(account_secret),
                          MW_POST_KEY_user_open_id:Value(user_open_id),
                          MW_POST_KEY_timestamp:@(timestamp1),
                          MW_POST_KEY_nonce:@(nonce),
                          MW_POST_KEY_sign:signComp,
                          MW_POST_KEY_invitation_code:Value(invitation_code),
                          };
    
    return [MWDictionaryUtils reviewDic:dic];
}

+ (BOOL)isUserLogin {
    NSString *user_open_id = [[MWCommonService sharedInstance] getuserOpenid];
    if ([MWCommonUtil isNotBlank:user_open_id]) {
        return YES;
    }
    return NO;
}

@end
