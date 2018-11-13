//
//  MerculetDefine.h
//  MerculetSDK
//
//  Created by wangwei on 2018/10/24.
//  Copyright © 2018 wangwei. All rights reserved.
//

#ifndef MerculetDefine_h
#define MerculetDefine_h

#import "MWStrategyConfigDefine.h"

#define ISPAD       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define ISIOS11     ([[[UIDevice currentDevice]systemVersion] floatValue]>10.9? 1:0)
#define ISIOS10     ([[[UIDevice currentDevice]systemVersion] floatValue]>9.9? 1:0)
#define ISIOS9      ([[[UIDevice currentDevice]systemVersion] floatValue]>8.9? 1:0)
#define ISIOS8      ([[[UIDevice currentDevice]systemVersion] floatValue]>7.9? 1:0)
#define DEVICE_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define Bundle_path            [[NSBundle mainBundle] pathForResource:@"MerculetSDK" ofType:@"bundle"]
#define MWBundle               [NSBundle bundleWithPath:Bundle_path]
#define MWLocalName                         @"MWLocalizable"

#define MW_SDK_VERSION                      @"4.2.180929"

#define MW_TEST                             @"https://statstest.mlinks.cc"//@"http://stats.test.magicwindow.cn"
#define MW_RC                               @"https://stats.rc.magicwindow.cn"
#define MW_RELEASE                          @"https://stats.mlinks.cc"//@"http://stats.magicwindow.cn"


//小咖秀
//#define MW_RELEASE                          @"https://stats.yzbo.tv"

#define MW_AD                                       1




// sdkBehaviour


// 域名
//#define MW_RELEASE_API @"https://openapi.merculet.cn" // 域名-国内
//#define MW_RELEASE_API @"https://openapi.merculet.io" // 域名-国外


// ---------   正式环境



// 事件
#define MW_TRACKING_URL @"https://openapi.merculet.cn/v1/event/sdkBehaviour"
//#define MW_TRACKING_URL @"https://openapi.merculet.io/v1/event/sdkBehaviour"

// 设备信息
#define MW_DEVICE_API @"https://openapi.merculet.cn/v1/user/device"
//#define MW_DEVICE_API @"https://openapi.merculet.io/v1/user/device"



// ---------   测试环境

// 事件
//#define MW_TRACKING_URL @"http://behaviour-tracking-cn.liaoyantech.cn/v1/event/sdkBehaviour"
//#define MW_TRACKING_URL @"http://behaviour-tracking.liaoyantech.cn/v1/event/sdkBehaviour"

// 设备信息
//#define MW_DEVICE_API @"http://score-query-cn.liaoyantech.cn/v1/user/device"
//#define MW_DEVICE_API @"http://score-query.liaoyantech.cn/v1/user/device"




// token
#define MW_Login_Token_API @""

// SDK version < 3.7 用/dp/dpls + /dp/getDPL
//#define MW_MLINK_GET_EVENT                  @"/dp/getDPL"   //DEPRECATED(3.7)
//#define MW_MLINK_ALL                        @"/dp/dpls"     //DEPRECATED(3.7)
#define MW_MLINK_ALL                        @"/dp/dpls/v2"
#define MW_MLINK_STRONG_MAPPING             @"/dp/cookie_mapping"
#define MW_MLINK_YYB                        @"/dp/dpl"

#define TRACKING_QUEUE                      @"magicwindow.tracking.queue1"
#define DEEP_LINK_QUEUE                     @"magicwindow.dpl"
#define CRASH_LOG_PATH                      @"mwlog"
#define CRASH_SDK_LOG_PATH               @"mwsdklog"
#define AD_BILLING_TRACKING_PATH        @"magicwindow.ad.billing"

#define SEND_STRATEGY_CHECK_INTERVAL        60
#define SEND_STRATEGY_CHECK_NUM             30

#define WEB_BOTTOM_TAG                      10010

#define EVENT_INSTALL_APP                   @"st"
#define EVENT_START_APP_KEY                 @"st"
#define EVENT_CLICK_AD_KEY                  @"c"
#define EVENT_ACTIVITY_VIEW                 @"ac"
#define EVENT_PAGE_VIEW                     @"pv"
#define EVENT_SHARE_KEY                     @"sh"
#define EVENT_AD_EXPOSURE                   @"i"    //impression
#define EVENT_CRASH_EXCEPTION               @"e"
#define EVENT_CARSH_SDK_EXCEPTION          @"emw"
#define EVENT_SHARE_FAILED_KEY              @"fail"
#define EVENT_USER_COSTUMED                 @"u"
#define EVENT_MLINK_CLICK                   @"mc"
#define EVENT_MLINK_INSTALL                 @"mi"
#define EVENT_MLINK_IMPRESSION              @"mv"
#define EVENT_MARKETING_KEYS                @"mwb"
#define EVENT_ABA_BACK                          @"abab"
#define EVENT_ABA_CLOSE                         @"abac"
#define EVENT_ABA_ASuccess                      @"abas"

#define MW_ERROR_GET_ACTIVITY_FAIL          @"No activities or activities have expired"//无相关活动或者活动已过期
#define MW_ERROR_NO_AD                          @"no ad"
#define MW_ERROR_UNKNOWN_ERROR             @"unknown error"     //未知错误


#endif /* MerculetDefine_h */
