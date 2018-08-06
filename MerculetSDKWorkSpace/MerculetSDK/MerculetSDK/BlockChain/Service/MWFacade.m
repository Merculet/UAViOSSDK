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
#import "MWSQLiteManager.h"
#import "MWStrategyConfig.h"
#import "MWRequestOperation.h"

#import "MerculetEncrypteHelper.h"
#import "MWTrackingDefine.h"
#import "MWCompositeEvent.h"
#import "MWURLRequestManager.h"
#import "MWHTTPURLResponse.h"
#import "MWHttpResponse.h"


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
        [MWSQLiteManager share];// 初始化数据库
    }
    return self;
}

- (void)registerApp:(nullable NSString *)appKey
         accountKey:(nullable NSString *)accountKey
      accountSecret:(nullable NSString *)accountSecret
{
    @try {
        if ([MWCommonUtil isBlank:appKey])
        {
            return;
        }

        // 保存更新相关配置
//        [self.commonService saveAndUpdateAppKey:appKey];
//        [self.commonService saveAndUpdateAccountKey:accountKey];
//        [self.commonService saveAndUpdateAccountSecret:accountSecret];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)setToken:(nullable NSString *)token userOpenId:(nonnull NSString *)userOpenId {
    
    // 移除配置信息和内存中的数据
    [self removeConfig];
    
    if ([MWCommonUtil isBlank:token]) {
        [MWLog log:@"token不能为空"];
        return;
    }
    if ([MWCommonUtil isBlank:userOpenId]) {
        [MWLog log:@"userOpenId不能为空"];
        return;
    }

    self.isLoginout = NO;
    // 保存新的userOpenId 和 token
    [[MWCommonService sharedInstance] saveAndUpdateUserOpenID:userOpenId];
    [[MWCommonService sharedInstance] saveAndUpdateMWToken:token];
}


- (void)cancelUserOpenId {
    // 去掉本地的userOpenId 和 token
    NSString *token = [[MWCommonService sharedInstance] getMWToken];
    NSString *userID = [[MWCommonService sharedInstance] getuserOpenid];
    self.isLoginout = YES;
    self.preToken = token;
    self.preuserID = userID;
    [[MW_ConnectionSessionManager sharedInstance] tick];
}

- (void)setInvitationCode:(nullable NSString *)invitation_code {
    if ([MWCommonUtil isNotBlank:invitation_code]) {
        [self.commonService saveAndUpdateInvitationCode:invitation_code];
    } else {
        [MWLog logForDev:@"invitation_code没有值"];
    }
}

- (void)setChinaEnable:(BOOL)enable  {
     [[MWCommonService sharedInstance] setChinaEnable:enable];
}

- (NSDictionary *)checkEventId:(nonnull NSString *)eventId
                       attributes:(nullable NSDictionary *)attributes  {
    
    @try {
        
        if (attributes != nil)
        {
            if (![attributes isKindOfClass:[NSDictionary class]])
            {
                [MWLog log:@"attributes只能为NSDictionary"];
                return nil;
            }
            
            if (attributes.allKeys.count > 9)
            {
                [MWLog log:@"attributes不能超过9个"];
                return nil;
            }
            
            id obj = [attributes objectForKey:@"action"];
            if (obj != nil)
            {
                [MWLog log:@"attributes的key不能包含action"];
                return nil;
            }
        }
        
        // 为事件添加所需要的内容
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        [parameter setValue:eventId forKey:@"action"];
        NSMutableDictionary *attributesMutable = [NSMutableDictionary dictionaryWithDictionary:attributes];
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval timestamp = [dat timeIntervalSince1970]*1000;
        NSString *timeString = [NSString stringWithFormat:@"%0.f", timestamp];
        [attributesMutable setValue:timeString forKey:@"sp_timestamp"];
        
        NSDictionary *dic = [MWDictionaryUtils reviewDic:attributesMutable];
        
        if ([MWCommonUtil isNotBlank:dic]) {
            [parameter setValue:attributesMutable forKey:@"action_params"];
            return parameter;
        } else {
            return nil;
        }
    } @catch (NSException *exception) {
        //        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"setCustomEvent:"];
    } @finally {
        
    }
}

- (void)setCustomAction:(nonnull NSString *)eventId
            attributes:(nullable NSDictionary *)attributes {
    @try {
        if ([MWCommonUtil isBlank:eventId])
        {
            [MWLog log:@"eventId不能为空"];
            return;
        }
        
        NSDictionary *parameter = [self checkEventId:eventId attributes:attributes];
        if ([MWCommonUtil isNotBlank:parameter]) {
            [[MW_ConnectionSessionManager sharedInstance] recordCustomEventDic:parameter];
        }
        
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"setCustomEvent:"];
    } @finally {
        
    }
}

- (void)setRealTimeCustomAction:(nonnull NSString *)action
             attributes:(nullable NSDictionary *)attributes
                success:(MWRealTimeSuccessBlock)successBlock
                failure:(MWRealTimeFailureBlock)failureBlock {
    @try {
        
        NSString *token = [[MWCommonService sharedInstance] getMWToken];
        if ([MWCommonUtil isBlank:token]) {return;}
        
        if ([MWCommonUtil isBlank:action])
        {
            [MWLog log:@"eventId不能为空"];
            return;
        }
        NSDictionary *attributesCopy = [attributes copy];
        NSDictionary *parameter = [self checkEventId:action attributes:attributesCopy];
        if ([MWCommonUtil isNotBlank:parameter]) {
            
            // 发送新的事件
            NSMutableArray *eventList = [[NSMutableArray alloc] init];
            [eventList addObject: attributes];
            MWCompositeEvent *comEvent = [[MWCompositeEvent alloc] init];
            NSDictionary *dic = [comEvent getCompositeEventDicWithEventsNoUser:eventList];
            
            NSString *jsonString = [MWDictionaryUtils dictionaryToJson:dic];
            NSDictionary *headers = [[[MWCompositeEvent alloc] init] headersWithParams:jsonString];
            
            if ([MWCommonUtil isBlank:headers] || [MWCommonUtil isBlank:jsonString]) {return;}
            
            /// body
            NSDictionary *bodyParam = @{MW_POST_KEY_EVENT_MW_info: jsonString};
            
            /// url
            NSString *urlDomain = [[MWCommonService sharedInstance] urlDomain];
            NSMutableString *url = [NSMutableString stringWithString:urlDomain];
            NSString *urlString = [url stringByAppendingString:MW_TRACKING_URL];
            
            [[MWURLRequestManager alloc] POST:urlString
                                      headers:headers
                                   parameters:bodyParam
                                      success:^(NSURLResponse *response, id responseObject, NSData *data) {
                                          
                                          int code = [MWHttpResponse getResponseCode:responseObject];
                                          NSString *message = [MWHttpResponse getResponseMessage:responseObject];
                                          
                                          if (code == 0) {
                                              successBlock();
                                          } else {
                                              MWHTTPURLResponse *response = [MWHTTPURLResponse response:message code:code];
                                              failureBlock(response);
                                          }
                                      } failure:^(NSURLResponse *response, NSError *error) {
                                          MWHTTPURLResponse *res = [MWHTTPURLResponse response:@"" code:-1];
                                          failureBlock(res);
                                      }];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

//- (void)registerWithInvitationCode:(nonnull NSString *)invitationCode {
//
//    NSDictionary *dic = @{@"invitationCode":Value(invitationCode)};
//    [self setCustomEvent:@"register" attributes:dic ];
//}
//
//- (void)chargeWithCount:(NSInteger)count {
//
//    NSDictionary *dic = @{@"amount":@(count)};
//    [self setCustomEvent:@"charge" attributes:dic];
//}
//
//- (void)signin {
//
//    NSDictionary *dic = nil;
//    [self setCustomEvent:@"signin" attributes:dic];
//}

// 切换用户时需要删除的东西
- (void)removeConfig {
    
    // 移除内存中的数据
    [[MWCommonService sharedInstance] removeMWToken];
    [[MWCommonService sharedInstance] removeuserOpenid];
}

@end
