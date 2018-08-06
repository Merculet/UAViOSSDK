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

#import "MWURLRequestManager.h"
#import "MWBlockChainDefine.h"
#import "MWCompositeEvent.h"
#import "MWDictionaryUtils.h"

// token失效回调
NSString * const MWTokenExpiredNotification = @"MWTokenExpiredNotification";

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

+ (void)cancelUserOpenId {
    [[MWFacade sharedInstance] cancelUserOpenId];
}

+ (void)showLogEnable:(BOOL)enable {
    [MWLog setDevLogEnable:enable];
}

#pragma mark -
#pragma mark - action

+ (void)event:(nonnull NSString *)action
   attributes:(nullable NSDictionary *)attributes {
    [[MWFacade sharedInstance] setCustomAction:action attributes:attributes];
}

+ (void)eventRealTime:(nonnull NSString *)action
           attributes:(nullable NSDictionary *)attributes
              success:(MWRealTimeSuccessBlock)successBlock
              failure:(MWRealTimeFailureBlock)failureBlock {
    [[[MWFacade alloc] init] setRealTimeCustomAction:action
                                          attributes:attributes
                                             success:successBlock
                                             failure:failureBlock];
}


#pragma mark -
#pragma mark - deprecated

+ (void)setCustomAction:(nonnull NSString *)action
             attributes:(nullable NSDictionary *)attributes {
    [[MWFacade sharedInstance] setCustomAction:action attributes:attributes];
}

+ (void)setCustomAction:(nonnull NSString *)action
             attributes:(nullable NSDictionary *)attributes
                success:(MWRealTimeSuccessBlock)successBlock
                failure:(MWRealTimeFailureBlock)failureBlock {
    
    [[[MWFacade alloc] init] setRealTimeCustomAction:action
                                          attributes:attributes
                                             success:successBlock
                                             failure:failureBlock];
    
}

+ (void)setChinaEnable:(BOOL)enable {
    [[MWFacade sharedInstance] setChinaEnable:enable];
}

@end
