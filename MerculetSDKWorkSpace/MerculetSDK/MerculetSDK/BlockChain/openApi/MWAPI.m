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

+ (void)setToken:(nullable NSString *)token {
    [[MWFacade sharedInstance] setToken: token];
}

+ (void)setUserOpenId:(nonnull NSString *)userOpenId invitationCode:(nullable NSString*)invitationCode
{
    [[MWFacade sharedInstance] setInvitationCode:invitationCode];
    [[MWFacade sharedInstance] setUserOpenId:userOpenId];
}


+ (void)cancelUserOpenId {
    
    [[MWFacade sharedInstance] cancelUserOpenId];
}

+ (void)showLogEnable:(BOOL)enable {
    [MWLog setDevLogEnable:enable];
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
