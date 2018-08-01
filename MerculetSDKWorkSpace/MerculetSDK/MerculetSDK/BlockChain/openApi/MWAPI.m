//
//  MWAPI.m
//  MWBlockChain
//
//  Created by 王伟 on 2018/3/12.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import "MWAPI.h"
#import "MWFacade.h"
#import "MWLog.h"

// token失效回调
NSString * const MWTokenExpiredNotification = @"MWTokenExpiredNotification";
// 在实时模式下，发送网络请求成功回调
NSString * const MWTokenExpiredRealTimeNotification = @"MWTokenExpiredRealTimeNotification";

@interface MWAPI ()

@end

@implementation MWAPI

+ (void)registerApp:(nonnull NSString *)appKey
         accountKey:(nonnull NSString *)accountKey
      accountSecret:(nonnull NSString *)accountSecret
{
    @try {
        [[MWFacade sharedInstance] registerApp:appKey
                                    accountKey:accountKey
                                 accountSecret:accountSecret];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

+ (void)registerApp
{
    [MWAPI registerApp:@"" accountKey:@"" accountSecret:@""];
}

+ (void)setToken:(nullable NSString *)token userID:(nullable NSString *)userID {
    [[MWFacade sharedInstance] setToken:token userOpenId:userID];
}

+ (void)setSendMode:(MWSendConfigType)sendType {
    [[MWFacade sharedInstance] setSendMode:sendType];
}

+ (void)cancelUserOpenId {
    [[MWFacade sharedInstance] cancelUserOpenId];
}

+ (void)showLogEnable:(BOOL)enable {
    [MWLog setDevLogEnable:enable];
}

/**
 *  设置是否是国内API
 */
+ (void)setChinaEnable:(BOOL)enable {
    [[MWFacade sharedInstance] setChinaEnable:enable];
}

#pragma mark -
#pragma mark - action

+ (void)registerWithInvitationCode:(nullable NSString *)invitationCode {
    [[MWFacade sharedInstance] registerWithInvitationCode:invitationCode];
}

+ (void)chargeWithCount:(NSInteger)count {
    [[MWFacade sharedInstance] chargeWithCount:count];
}

+ (void)signin {
    [[MWFacade sharedInstance] signin];
}

+ (void)setCustomAction:(nonnull NSString *)action attributes:(nullable NSDictionary *)attributes {
    [[MWFacade sharedInstance] setCustomEvent:action attributes:attributes];
}

@end
