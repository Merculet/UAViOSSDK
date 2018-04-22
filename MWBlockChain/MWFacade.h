//
//  MWFacade.h
//  MWBlockChain
//
//  Created by 王伟 on 2018/3/12.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWFacade : NSObject

+(nonnull id) sharedInstance;

- (void)registerApp:(nonnull NSString *)appKey
         accountKey:(nonnull NSString *)accountKey
      accountSecret:(nonnull NSString *)accountSecret;

- (void)setUserOpenId:(nonnull NSString *)userOpenId;

- (void)setInvitationCode:(nullable NSString *)invitation_code;

- (void)cancelUserOpenId;




// 事件
- (void)registerWithInvitationCode:(nonnull NSString *)invitationCode;

- (void)chargeWithCount:(NSInteger)count;

- (void)signin;

- (void)setCustomEvent:(nonnull NSString *)eventId attributes:(nullable NSDictionary *)attributes;

@end
