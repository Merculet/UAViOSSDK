//
//  MWEventInfo.m
//
//
//  Created by 刘家飞 on 14/11/9.
//  Copyright (c) 2014年 All rights reserved.
//

#import "MWEventInfo.h"
#import "MWDictionaryUtils.h"
#import "MWReachability.h"
#import "MWCommonUtil.h"
#import "MWDeviceUtil.h"
//#import "MWmLinkCommonService.h"

#import "MWTrackingDefine.h"

@implementation MWEventInfo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        self.startTime = [NSDate date];
    }
    return self;
}

    // 事件需要的配置信息
- (NSMutableDictionary *)getEventDic
{
    NSDictionary *dic = @{MW_POST_KEY_EVENT_app_key:Value_class(self.action),
                          MW_POST_KEY_EVENT_actions:Value_class(self.action_params),
                          MW_POST_KEY_EVENT_external_user_id:Value(nil),
                          MW_POST_KEY_EVENT_device_info:Value_class(self.device_info),
                          };
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    return [MWDictionaryUtils reviewDic:newDic];
}


- (NSDictionary *)device_info {
    
    
    NSDictionary *dic = @{MW_POST_KEY_EVENT_device_info_IDFA:Value_class(self.idfa),
                          MW_POST_KEY_EVENT_device_info_OS: Value_class(@"1")
                          };
    return dic;
}

- (NSString *)idfa {
    NSString *idfa = [MWDeviceUtil getIDFA];
    return idfa;
}

    // 获取
//- (NSString *)mlinkTimeStr
//{
//    if (self.mlinkTime == nil)
//    {
//        return nil;
//    }
//    NSNumber *number = @((NSInteger)[self.mlinkTime timeIntervalSince1970]);
//    return [NSString stringWithFormat:@"%@",number];
//}

/*
 wifi = 0
 2G = 1
 3G = 2
 4G = 3
 */
//- (NSUInteger)getNetwork
//{
//    NSUInteger net = 0;
//    MWNetworkStatus status = [MWReachability getNetworkStatus];
//    switch (status) {
//        case ReachableViaWiFi:
//        {
//            net = 0;
//            break;
//        }
//        case ReachableVia2G:
//        {
//            net = 1;
//            break;
//        }
//        case ReachableVia3G:
//        {
//            net = 2;
//            break;
//        }
//        case ReachableVia4G:
//        {
//            net = 3;
//            break;
//        }
//
//        default:
//        {
//            net = 5;
//            break;
//        }
//    }
//    self.network = net;
//    return net;
//}

@end
