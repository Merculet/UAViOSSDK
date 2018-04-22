//
//  MWAPI.h
//  MerculetSDK
//
//  Created by 王伟 on 2018/3/12.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEPRECATED(_version) __attribute__((deprecated))

@interface MWAPI : NSObject

#pragma mark -
#pragma mark - init

/**
 *  注册app
 *  需要在 application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 中调用
 *  @param appKey            后台注册的appkey
 *  @param accountKey        后台注册的accountKey
 *  @param accountSecret     后台注册的accountSecret
 */
+ (void)registerApp:(nonnull NSString *)appKey
         accountKey:(nonnull NSString *)accountKey
      accountSecret:(nonnull NSString *)accountSecret;

/**
 *  注册或者切换用户账号
 *  可以在切换用户账号的时候调用
 *  @param userOpenId        用户名
 *  @param invitationCode    邀请码
 */
+ (void)setUserOpenId:(nonnull NSString *)userOpenId invitationCode:(nullable NSString*)invitationCode;

/**
 *  取消追踪当前用户
 */
+ (void)cancelUserOpenId;


#pragma mark -
#pragma mark - action


/**
 *  自定义事件
 *  @param action 自定义事件的唯一标示，不能为空
 *  @param attributes 动态参数，最多可包含9个
 */
+ (void)setCustomAction:(nonnull NSString *)action attributes:(nullable NSDictionary *)attributes;

@end
