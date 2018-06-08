//
//  MWCommonService.h
//
//
//  Created by 刘家飞 on 14/11/20.
//  Copyright (c) 2014年  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWCommonUtil.h"
//#import "MWmLinkUrlConfig.h"


@interface MWCommonService : NSObject

@property (nonatomic, strong) NSString *mwChannel;  //渠道
@property (nonatomic, assign) BOOL webviewNotificationEnable;   //判断webview是否发送通知
@property (nonatomic, assign) BOOL barEditEnable;   //判断webview的导航条是否自定义
@property (nonatomic, strong) NSString *cityCode;   //城市编码
@property (nonatomic, strong) NSString *mwUrl;      //默认为release
@property (nonatomic, assign) long marketingLastestTime;



+ (id)sharedInstance;

- (void)saveAndUpdateAppKey:(NSString *)appKey;
- (void)saveAndUpdateAccountKey:(NSString *)accountKey;
- (void)saveAndUpdateAccountSecret:(NSString *)accountSecret;
- (void)saveAndUpdateUserOpenID:(NSString *)userOpenID;
- (void)saveAndUpdateInvitationCode:(NSString *)invitationCode;


- (void)removeInvitationCode;

- (void)saveAndUpdateStrategyConfig:(NSData *)data LastUpdateTime:(NSDate *)lastUpdateTime MWAppKey:(NSString *)appKey;
- (NSData *)getStrategyConfig;
- (NSDate *)getStrategyLastUpdateTime;

//- (void)setChinaEnable:(BOOL)enable;
//- (BOOL)getChinaEnable;

- (void)saveAndUpdateCampaignConfig:(NSData *)data;
- (NSData *)getCampaignConfig;
- (void)saveAndUpdateMarketingLastestTime:(long)time;
- (NSNumber *)getMarketingLastestTime;

- (NSString *)getAppKey;
- (NSString *)getIDFA;
- (NSString *)getAccountKey;
- (NSString *)getAccountSecret;
- (NSString *)getuserOpenid;
- (NSString *)getInvitationCode;
- (NSString *)getMWToken;
- (void)saveAndUpdateMWToken:(NSString *)token;
- (void)removeMWToken;


- (void)removeuserOpenid;

- (void)saveFingerPrint:(NSString *)fingerPrint;
- (NSString *)getFingerPrint;

//判断是否是第一次启动app
- (void)appFirstStartLaunch;
- (NSString *)appFirstStartTime;
- (BOOL)isAppFirstStartLaunch;

//userAgent
- (void)saveUserAgent:(NSString *)agent;
- (NSString *)getUserAgent;

/// 获取域名
- (NSString *)urlDomain;

// 保存配置文件、获取配置
//+(void)saveStrValueInUD:(NSString *)str forKey:(NSString *)key;
//+(NSString *)getStrValueInUDWithKey:(NSString *)key;

@end
