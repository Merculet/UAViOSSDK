//
//  MWFacade.m
//  MWBlockChain
//
//  Created by 王伟 on 2018/3/12.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import "MWFacade.h"
#import "MWCommonUtil.h"
#import "MW_ConnectionSessionManager.h"
#import "MWLog.h"
#import "MWCommonService.h"
#import "MWDictionaryUtils.h"
#import "MWCommonUtil.h"
#import "MWSendStrategyManager.h"
#import "MWBlockChainDefine.h"


@interface MWFacade ()

@property (nonatomic, strong) MWCommonService *commonService;
@property (nonatomic, strong) NSMutableDictionary *campaignDic;
@property (nonatomic, strong) NSMutableDictionary *adDic;
//设置后台环境
@property (nonatomic, strong) NSString *mwUrl;

@end

@implementation MWFacade

+ (id)sharedInstance
{
    static MWFacade *mwFacade = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        mwFacade = [[MWFacade alloc] init];
    });
    return mwFacade;
}

-(id) init
{
    if (self = [super init])
    {
       self.commonService = [MWCommonService sharedInstance];
        
        
        //初始化session manager
        [MW_ConnectionSessionManager sharedInstance];
        [MWSendStrategyManager sharedInstance];
        
    }
    return self;
}

- (void)registerApp:(nonnull NSString *)appKey
         accountKey:(nonnull NSString *)accountKey
      accountSecret:(nonnull NSString *)accountSecret
{
    @try {
        if ([MWCommonUtil isBlank:appKey])
        {
            return;
        }

        // 保存更新相关配置
        [self.commonService saveAndUpdateAppKey:appKey];
        [self.commonService saveAndUpdateAccountKey:accountKey];
        [self.commonService saveAndUpdateAccountSecret:accountSecret];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)setUserOpenId:(nonnull NSString *)userOpenId {
    
    // 移除配置信息和内存中的数据
//    [self removeConfig];
    
    if ([MWCommonUtil isNotBlank:userOpenId]) {
        [[MW_ConnectionSessionManager sharedInstance] initTokneWithUserOpenid:userOpenId];
    } else {
        [MWLog logForDev:@"userOpenId不能为空"];
    }
}

- (void)cancelUserOpenId {
    [[MWCommonService sharedInstance] removeuserOpenid];
}

- (void)setInvitationCode:(nullable NSString *)invitation_code {
    
    if ([MWCommonUtil isNotBlank:invitation_code]) {
        [self.commonService saveAndUpdateInvitationCode:invitation_code];
    } else {
        [MWLog logForDev:@"invitation_code没有值"];
    }
}

- (void)setCustomEvent:(nonnull NSString *)eventId attributes:(nullable NSDictionary *)attributes {
    @try {
        if ([MWCommonUtil isBlank:eventId])
        {
            [MWLog log:@"eventId不能为空"];
            return;
        }
        
        if (attributes != nil)
        {
            if (![attributes isKindOfClass:[NSDictionary class]])
            {
                [MWLog log:@"attributes只能为NSDictionary"];
                return;
            }
            
            if (attributes.allKeys.count > 9)
            {
                [MWLog log:@"attributes不能超过9个"];
                return;
            }
            
            id obj = [attributes objectForKey:@"action"];
            if (obj != nil)
            {
                [MWLog log:@"attributes的key不能包含action"];
                return;
            }
        }
        
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        [parameter setValue:eventId forKey:@"action"];
        
        NSDictionary *dic = [MWDictionaryUtils reviewDic:attributes];
        if ([MWCommonUtil isNotBlank:dic]) {
            [parameter setValue:attributes forKey:@"actions_params"];
        }
        
        [[MW_ConnectionSessionManager sharedInstance] recordCustomEventDic:parameter];
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"setCustomEvent:"];
    } @finally {
        
    }
}


- (void)registerWithInvitationCode:(nonnull NSString *)invitationCode {
    
    NSDictionary *dic = @{@"invitationCode":Value(invitationCode)};
    [self setCustomEvent:@"register" attributes:dic];
}

- (void)chargeWithCount:(NSInteger)count {
    
    NSDictionary *dic = @{@"amount":@(count)};
    [self setCustomEvent:@"charge" attributes:dic];
}

- (void)signin {
    
    NSDictionary *dic = nil;
    [self setCustomEvent:@"signin" attributes:dic];
}

// 切换用户时需要删除的东西
- (void)removeConfig {
    
    // 移除内存中的数据
    [[MW_ConnectionSessionManager sharedInstance] tick];
}

@end
