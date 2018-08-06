//
//  MWStrategyConfig.m
//  MerculetSDK
//
//  Created by 王大吉 on 30/7/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import "MWStrategyConfig.h"
#import "MWTrackingDefine.h"


@implementation MWSendConfig

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _batchSize = SEND_STRATEGY_CHECK_NUM;
        _period = SEND_STRATEGY_CHECK_INTERVAL;
    }
    return self;
}


@end

@implementation MWStrategyConfig

+ (id)sharedInstance
{
    static MWStrategyConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    return config;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.sendConfig = [[MWSendConfig alloc] init];
    }
    return self;
}

@end
