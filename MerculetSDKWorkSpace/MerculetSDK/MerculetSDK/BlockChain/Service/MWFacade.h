//
//  MWFacade.h
//  MWBlockChain
//
//  Created by 王伟 on 2018/3/12.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWFacade : NSObject

// 是否强制发送数据
@property (nonatomic, assign) BOOL isLoginout;
@property (atomic, copy)  NSString *preToken;
@property (atomic, copy)  NSString *preuserID;


+(nonnull id) sharedInstance;

- (void)registerApp:(nullable NSString *)appKey
         accountKey:(nullable NSString *)accountKey
      accountSecret:(nullable NSString *)accountSecret;

- (void)setToken:(nullable NSString *)token userOpenId:(nonnull NSString *)userOpenId;

- (void)setInvitationCode:(nullable NSString *)invitation_code;

- (void)cancelUserOpenId;

- (void)setChinaEnable:(BOOL)enable;

// 事件
- (void)registerWithInvitationCode:(nonnull NSString *)invitationCode;

- (void)chargeWithCount:(NSInteger)count;

- (void)signin;

- (void)setCustomEvent:(nonnull NSString *)eventId attributes:(nullable NSDictionary *)attributes;

// 切换用户时需要删除的东西
- (void)removeConfig;

@end
