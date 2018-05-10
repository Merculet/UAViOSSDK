//
//  MWCommonService.m
//
//
//  Created by 刘家飞 on 14/11/20.
//  Copyright (c) 2014年 All rights reserved.
//

#import "MWCommonService.h"
#import <AdSupport/ASIdentifierManager.h>
#import "MWBlockChainDefine.h"

#define MW_CS_STRATEGY_CONFIG_DATA             @"mw_sc"
#define MW_CS_CAMPAIGN_CONFIG_DATA             @"mw_cc"

// 四个标识
#define MW_CS_STRATEGY_APP_KEY                 @"mw_ak"
#define MW_CS_STRATEGY_ACCOUNR_KEY             @"mw_ack"
#define MW_CS_STRATEGY_ACCOUNR_SECRET          @"mw_acs"
#define MW_CS_STRATEGY_USER_OPEN_ID            @"mw_uoi"
#define MW_CS_STRATEGY_Invitation_Code         @"mw_ic"


#define MW_CS_STRATEGY_FP                      @"mw_fp"
#define MW_CS_STRATEGY_LAST_UPDATE_TIME        @"mw_sst"
#define MW_CS_APP_CHANNEL                      @"mw_ac"
#define MW_CS_APP_FIRST_START_TIME             @"mw_ft"
#define MW_CS_APP_FIRST_START_LAUNCH           @"mw_n"
#define MW_CS_MARKETING_TIME                   @"mw_mt"
#define MW_CS_UA                               @"mw_ua"

// token
#define MW_CS_Token                              @"mw_token"



@implementation MWCommonService

+ (id)sharedInstance
{
    static MWCommonService *commonService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commonService = [[self alloc] init];
    });
    return commonService;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.webviewNotificationEnable = NO;
        self.barEditEnable = NO;
        self.mwUrl = MW_RELEASE;
    }
    return self;
}



- (void)saveAndUpdateMWToken:(NSString *)token
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:MW_CS_Token];
    [userDefaults synchronize];
}


- (void)saveAndUpdateAppKey:(NSString *)appKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:appKey forKey:MW_CS_STRATEGY_APP_KEY];
    [userDefaults synchronize];
}

- (void)saveAndUpdateAccountKey:(NSString *)accountKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:accountKey forKey:MW_CS_STRATEGY_ACCOUNR_KEY];
    [userDefaults synchronize];
}

- (void)saveAndUpdateAccountSecret:(NSString *)accountSecret
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:accountSecret forKey:MW_CS_STRATEGY_ACCOUNR_SECRET];
    [userDefaults synchronize];
}

- (void)saveAndUpdateUserOpenID:(NSString *)userOpenID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userOpenID forKey:MW_CS_STRATEGY_USER_OPEN_ID];
    [userDefaults synchronize];
}

- (void)saveAndUpdateInvitationCode:(NSString *)invitationCode
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:invitationCode forKey:MW_CS_STRATEGY_Invitation_Code];
    [userDefaults synchronize];
}

- (void)saveAndUpdateStrategyConfig:(NSData *)data LastUpdateTime:(NSDate *)lastUpdateTime MWAppKey:(NSString *)appKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:MW_CS_STRATEGY_CONFIG_DATA];
    [userDefaults setObject:appKey forKey:MW_CS_STRATEGY_APP_KEY];
    [userDefaults setObject:lastUpdateTime forKey:MW_CS_STRATEGY_LAST_UPDATE_TIME];
    [userDefaults synchronize];
}

- (void)removeInvitationCode {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:MW_CS_STRATEGY_Invitation_Code];
}

- (void)removeuserOpenid {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:MW_CS_STRATEGY_USER_OPEN_ID];
}

- (NSData *)getStrategyConfig
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults dataForKey:MW_CS_STRATEGY_CONFIG_DATA];
}

- (NSDate *)getStrategyLastUpdateTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:MW_CS_STRATEGY_LAST_UPDATE_TIME];
}

- (void)saveAndUpdateCampaignConfig:(NSData *)data
{
    if (data == nil)
    {
        data = [NSData new];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:MW_CS_CAMPAIGN_CONFIG_DATA];
    [userDefaults synchronize];
}

- (NSData *)getCampaignConfig
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults dataForKey:MW_CS_CAMPAIGN_CONFIG_DATA];
}

- (void)saveAndUpdateMarketingLastestTime:(long)time
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(time) forKey:MW_CS_MARKETING_TIME];
    [userDefaults synchronize];
}

- (NSNumber *)getMarketingLastestTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:MW_CS_MARKETING_TIME];
}

- (NSString *)getMWToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:MW_CS_Token];
}

- (NSString *)getAppKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:MW_CS_STRATEGY_APP_KEY];
}

- (NSString *)getAccountKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:MW_CS_STRATEGY_ACCOUNR_KEY];
}

- (NSString *)getAccountSecret
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:MW_CS_STRATEGY_ACCOUNR_SECRET];
}

- (NSString *)getuserOpenid
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:MW_CS_STRATEGY_USER_OPEN_ID];
}

- (NSString *)getInvitationCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:MW_CS_STRATEGY_Invitation_Code];
}



- (NSString *)getIDFA
{
    return NSClassFromString(@"ASIdentifierManager")?[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]:nil;
}

- (void)saveFingerPrint:(NSString *)fingerPrint
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:fingerPrint forKey:MW_CS_STRATEGY_FP];
    [userDefaults synchronize];
}

- (NSString *)getFingerPrint
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:MW_CS_STRATEGY_FP];
}

- (void)setMwChannel:(NSString *)mwChannel
{
    _mwChannel = mwChannel;
}

- (void)appFirstStartLaunch
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *time = [self appFirstStartTime];
    if (time == nil || [time length] == 0)
    {
        [userDefaults setObject:[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]] forKey:MW_CS_APP_FIRST_START_TIME];
        [userDefaults setObject:@YES forKey:MW_CS_APP_FIRST_START_LAUNCH];
    }
    else
    {
        [userDefaults setObject:@NO forKey:MW_CS_APP_FIRST_START_LAUNCH];
    }
    
    [userDefaults synchronize];
}

- (NSString *)appFirstStartTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:MW_CS_APP_FIRST_START_TIME];
}

- (BOOL)isAppFirstStartLaunch
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id isFirst = [defaults objectForKey:MW_CS_APP_FIRST_START_LAUNCH];
    return isFirst==nil?YES:[defaults boolForKey:MW_CS_APP_FIRST_START_LAUNCH];
}

//userAgent
- (void)saveUserAgent:(NSString *)agent
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:agent forKey:MW_CS_UA];
    [userDefaults synchronize];
}

- (NSString *)getUserAgent
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:MW_CS_UA];
}

@end
