//
//  MWAPI.h
//  MerculetSDK
//
//  Created by 王伟 on 2018/3/12.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEPRECATED(_version) __attribute__((deprecated))

typedef enum : NSUInteger {
    MWSendConfigTypeNormal,
    MWSendConfigTypeRealTime,
} MWSendConfigType;

/**
 *  token失效回调回调
 */
extern NSString * _Nonnull const MWTokenExpiredNotification;
/**
 *  在实时模式下，发送网络请求成功回调
 */
extern NSString * _Nonnull const MWTokenExpiredRealTimeNotification;


@interface MWAPI : NSObject

#pragma mark -
#pragma mark - init


/**
 *  注册app
 *  需要在 application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 中调用
 */
+ (void)registerApp;

/**
 *  向sdk设置token
 *  必须是没有失效的token
 */
+ (void)setToken:(nullable NSString *)token userID:(nullable NSString *)userID;

/**
 *  设置发送模式
 *  默认发送模式：MWSendConfigTypeNormal，
 *  实时发送模式：MWSendConfigTypeRealTime
 */
+ (void)setSendMode:(MWSendConfigType)sendType;

/**
 *  取消追踪当前用户
 *  cancel tracking
 */
+ (void)cancelUserOpenId;

/**
 *  show debug
 */
+ (void)showLogEnable:(BOOL)enable;

/**
 *  设置是否是国内API
 */
+ (void)setChinaEnable:(BOOL)enable __attribute__((deprecated("the method can't play")));


#pragma mark -
#pragma mark - action


/**
 *  自定义事件
 *  @param action 自定义事件的唯一标示，不能为空
 *  @param attributes 动态参数，最多可包含9个
 */
+ (void)setCustomAction:(nonnull NSString *)action attributes:(nullable NSDictionary *)attributes;

@end