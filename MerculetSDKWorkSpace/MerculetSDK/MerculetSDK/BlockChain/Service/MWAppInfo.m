//
//  MWAppInfo.m
//  MagicWindowSampleApp
//
//  Created by 刘家飞 on 16/4/27.
//  Copyright © 2016年 MagicWindow. All rights reserved.
//

#import "MWAppInfo.h"
#import "MWCommonService.h"
#import "MerculetDefine.h"
#import "MWPostServiceKey.h"
#import "MWDictionaryUtils.h"

@implementation MWAppInfo

- (NSDictionary *)getAppInfo
{
    NSDictionary *device = @{MW_POST_KEY_APP_KEY:Value_class([[MWCommonService sharedInstance] getAppKey]),
                             MW_POST_KEY_SDK_VERSION:Value_class([self getSDKVersion]),
                             MW_POST_KEY_APP_VERSION:Value_class([self getAppVersion])};
    return [MWDictionaryUtils reviewDic:device];
}

- (NSString *)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)getSDKVersion
{
    return MW_SDK_VERSION;
}

- (NSString *)getBundleID
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleIdentifierKey];
}

- (NSString *)appFirstStartTime
{
    return [[MWCommonService sharedInstance] appFirstStartTime];
}

- (NSString *)getAppName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

@end
