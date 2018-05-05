//
//  MW_ConnectionSessionManager.m
//  MerculetSDK
//
//  Created by 王大吉 on 25/4/2018.
//  Copyright © 2018 王伟. All rights reserved.
//

#import "MW_ConnectionSessionManager.h"
#import "MW_ConnectionSession.h"
#import "MWSendStrategyManager.h"
#import "MWCommonService.h"

@interface MW_ConnectionSessionManager ()
@property(nonatomic, strong) MW_ConnectionSession *session;
@property(nonatomic, strong) MWSendStrategyManager *sendStrategyManager;
@end

@implementation MW_ConnectionSessionManager

+ (id)sharedInstance
{
    static MW_ConnectionSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[MW_ConnectionSessionManager alloc] init];
    });
    return sessionManager;
}

- (instancetype)init {
    if (self = [super init]) {
        MW_ConnectionSession *session = [[MW_ConnectionSession alloc] initWithType:MW_ConnectionSessionCustom];
        self.session = session;
        MWSendStrategyManager *sendStrategyManager = [MWSendStrategyManager sharedInstance];
        self.sendStrategyManager = sendStrategyManager;
    }
    return self;
}

- (void)tick {
    self.session.willTerminate = self.willTerminate;
    [self.session tick];
}

- (void)recordCustomEventDic: (nonnull NSDictionary *)eventDic {
    [self.session recordEventDic:eventDic];
}

- (void)initTokneWithUserOpenid: (nonnull NSString *)userOpenid {
    /// 切换账户
    [self.session tick];
    [[MWCommonService sharedInstance] saveAndUpdateUserOpenID:userOpenid];
    
}

@end
