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
#import "MerculetDefine.h"
#import "MWSQLiteManager.h"
#import "MWStrategyConfig.h"
#import "MWRequestOperation.h"

#import "MerculetEncrypteHelper.h"
#import "MWTrackingDefine.h"
#import "MWCompositeEvent.h"
#import "MWURLRequestManager.h"
#import "MWHTTPURLResponse.h"
#import "MWHttpResponse.h"
#import "MWPostServiceKey.h"
#import "MWURLService.h"
#import "MWRealTimeOperationManager.h"
#import "MWDeviceService.h"
#import "MWDeviceService.h"
#import "MWLog.h"

@interface MWFacade ()<UIWebViewDelegate>

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
        
        if ([self.commonService getFingerPrint] == nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getFingerprint];
            });
        }
        
        // 配置是否是第一次启动
        [self.commonService appFirstStartLaunch];
        
        // 上传设备信息
        [MWDeviceService updateUserInfo];
        
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
//    [self removeConfig];
    
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
    
    [MWDeviceService updateUserInfo];
    
    [MWLog logForDev:@"success: SDK集成成功，可以上传事件"];
}


- (void)cancelUserOpenId {
    // 去掉本地的userOpenId 和 token
//    NSString *token = [[MWCommonService sharedInstance] getMWToken];
//    NSString *userID = [[MWCommonService sharedInstance] getuserOpenid];
    self.isLoginout = YES;
//    self.preToken = token;
//    self.preuserID = userID;
    
    [[MW_ConnectionSessionManager sharedInstance] tick];
}

- (void)setInvitationCode:(nullable NSString *)invitation_code {
    if ([MWCommonUtil isNotBlank:invitation_code]) {
        [self.commonService saveAndUpdateInvitationCode:invitation_code];
    } else {
        [MWLog log:@"invitation_code没有值"];
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
            
//            if (attributes.allKeys.count > 9)
//            {
//                [MWLog log:@"attributes不能超过9个"];
//                return nil;
//            }
            
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
             attributes:(nullable NSDictionary *)attributes {
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
            
            MWRealTimeOperationManager *realTimeOperation = [[MWRealTimeOperationManager alloc] init];
            [realTimeOperation setRealTimeCustomAction:action originParameter:attributes parameter:parameter];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *fp = [webView stringByEvaluatingJavaScriptFromString:@"getFingerPrint();"];
    [self.commonService saveFingerPrint:fp];
    [webView removeFromSuperview];
}

- (void)getFingerprint
{
    @try {
        UIWebView *webView = [[UIWebView alloc] init];
        webView.delegate = self;
        
        UIViewController *viewcon = [self getRootViewController];
        [viewcon.view addSubview:webView];
        NSString *filePath = [MWBundle pathForResource:@"fingerprint" ofType:@"html"];
        if ([MWCommonUtil isBlank:filePath]) return;
        NSURL *url = [NSURL fileURLWithPath:filePath];
        if ([MWCommonUtil isNotBlank:url])
        {
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    } @catch (NSException *exception) {
       
    } @finally {
        
    }
}
-(UIViewController*) getRootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
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
    
    [MWLog logForDev:@"移除了用户信息"];
}

@end
