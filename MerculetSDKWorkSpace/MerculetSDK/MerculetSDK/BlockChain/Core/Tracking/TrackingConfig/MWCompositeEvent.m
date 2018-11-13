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
#import "MWFacade.h"
#import "MerculetEncrypteHelper.h"
#import "MWPostServiceKey.h"


@implementation MWCompositeEvent

- (nullable NSMutableDictionary *)headersWithParams:(NSString *)jsonString {
    
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    
    // 获取token
    NSString *token = @"";
    token = [[MWCommonService sharedInstance] getMWToken];
    
    // 生成sign
    NSString *sign = [MerculetEncrypteHelper generateString:jsonString];
    
    if ([MWCommonUtil isNotBlank:token] && [MWCommonUtil isNotBlank:sign]) {
        [headers setValue:token forKey:MW_POST_KEY_EVENT_MW_TOKEN]; // 设置token
        [headers setValue:sign  forKey:MW_POST_KEY_EVENT_MW_SIGN];  // 设置sign
        return headers;
    } else {
        return nil;
    }
}

- (NSDictionary *)getCompositeEventDicWithEvents:(NSArray *)events
{
    @try {
        if ([MWCommonUtil isBlank:events])
        {
            return nil;
        }
        NSDictionary *dic = @{
                              MW_POST_KEY_EVENT_DEVICE_INFO: Value_class([[MWDeviceUtil share] getDevice]),
                              MW_POST_KEY_EVENT_ACTIONS: events,
                              MW_POST_KEY_EVENT_MW_USERID: Value([[MWCommonService sharedInstance] getuserOpenid])
                              };
        return [MWDictionaryUtils reviewDic:dic];
    } @catch (NSException *exception) {
    } @finally {
    }
}

- (NSDictionary *)getCompositeEventDicWithEventsNoUser:(NSArray *)events
{
    @try {
        if ([MWCommonUtil isBlank:events])
        {
            return nil;
        }
        NSDictionary *dic = @{
                              MW_POST_KEY_EVENT_DEVICE_INFO:Value_class([[MWDeviceUtil share] getDevice]),
                              MW_POST_KEY_EVENT_ACTIONS:events
                              };
        
        return [MWDictionaryUtils reviewDic:dic];
    } @catch (NSException *exception) {
    } @finally {
    }
}


//+ (NSDictionary *)getLoginToken {
//    
//    //    [MWLog logForDev:@"当前线程：%@",[]];
//   
//    NSString *app_key = [[MWCommonService sharedInstance] getAppKey];
//    NSString *account_key = [[MWCommonService sharedInstance] getAccountKey];
//    NSString *account_secret = [[MWCommonService sharedInstance] getAccountSecret];
//    NSString *invitation_code = [[MWCommonService sharedInstance] getInvitationCode];
//    NSString *user_open_id = [[MWCommonService sharedInstance] getuserOpenid];
//    NSInteger timestamp1 = (NSInteger)([[NSDate date] timeIntervalSince1970] * 1000);
//    NSInteger nonce = [MWNSStringUtils createRandomNum].integerValue;
//    
//    NSString *timestampStr = [NSString stringWithFormat:@"%ld",(long)timestamp1];// 毫秒事件
//    NSString *nonceStr = [NSString stringWithFormat:@"%ld",(long)nonce];
//    
//    NSMutableString *sign = [NSMutableString string];
//    [sign appendString:Value(account_key)];
//    [sign appendString:Value(app_key)];
//    [sign appendString:Value(invitation_code)];
//    [sign appendString:Value(nonceStr)];
//    [sign appendString:Value(timestampStr)];
//    [sign appendString:Value(user_open_id)];
//    [sign appendString:Value(account_secret)];
//    
//    // 加密
//    NSString *signComp = [MWNSStringUtils MD5TO32Lower:sign];
//    
//    NSDictionary *dic = @{
//                          MW_POST_KEY_APP_KEY:Value(app_key),
//                          MW_POST_KEY_ACCOUNT_KEY:Value(account_key),
////                          MW_POST_KEY_account_secret:Value(account_secret),
//                          MW_POST_KEY_USER_OPEN_ID:Value(user_open_id),
//                          MW_POST_KEY_TIMESTAMP:@(timestamp1),
//                          MW_POST_KEY_NONCE:@(nonce),
//                          MW_POST_KEY_SIGN:signComp,
//                          MW_POST_KEY_INVITATION_CODE:Value(invitation_code),
//                          };
//    
//    return [MWDictionaryUtils reviewDic:dic];
//}
//
//+ (BOOL)isUserLogin {
//    NSString *user_open_id = [[MWCommonService sharedInstance] getuserOpenid];
//    if ([MWCommonUtil isNotBlank:user_open_id]) {
//        return YES;
//    }
//    return NO;
//}

@end
