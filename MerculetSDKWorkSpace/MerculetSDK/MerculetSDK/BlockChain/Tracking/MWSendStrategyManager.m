//
//  MWSendStrategyManager.m
//
//
//  Created by 刘家飞 on 14/12/11.
//  Copyright (c) 2014年 All rights reserved.
//

#import "MWSendStrategyManager.h"
#import "MW_ConnectionSessionManager.h"
#import <UIKit/UIKit.h>
#import "MWTimerManager.h"
#import "MWCompositeEvent.h"

static NSString *MWTimer = @"MWTimer";
//static NSString *MWTimer = @"MWTimer";

@interface MWSendStrategyManager ()

@end

@implementation MWSendStrategyManager

+ (id)sharedInstance
{
    static MWSendStrategyManager *sendManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sendManager = [[self alloc] init];
    });
    return sendManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification object:nil];
        //监听是否重新进入程序.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification object:nil];
        
        // 程序被杀掉
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminateNotification:)
                                                     name:UIApplicationWillTerminateNotification object:nil];

        
    }
    return self;
}

- (void)startSendStrategy
{
    [self uploadEvent];
    [self startTimer];
}

- (void)startTimer
{
    @try {
        
//        MWStrategyConfig *mwConfig = [MWStrategyConfig sharedInstance];
//        MWSendConfig *sendConfig = mwConfig.sendConfig;
//        double period = 60 * 3;
        double period = 60;
        [[MWTimerManager shareInstance] scheduledDispatchTimerWithName:MWTimer
//                                                          timeInterval:(double)sendConfig.period
                                                          timeInterval:period
                                                                 queue:nil
                                                               repeats:YES
                                                          actionOption:MWAbandonPreviousAction action:^{
            [self uploadEvent];
        }];
        
    } @catch (NSException *exception) {
        // [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"startTimer"];
    } @finally {

    }
}

- (void)stopTimer
{
    @try {
        [[MWTimerManager shareInstance] cancelAllTimer];
        
    } @catch (NSException *exception) {
        // [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"stopTimer"];
    } @finally {
        
    }
}

- (void)uploadEvent
{
   [[MW_ConnectionSessionManager sharedInstance] tick];
}

- (void)enterBackground:(NSNotification*)notification
{
    UIApplication *application = [UIApplication sharedApplication];

    
    // 进入后台 延时做点事情
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(),^{
            [application endBackgroundTask:bgTask];
            NSLog(@"====任务完成了。。。。。。。。。。。。。。。===>");
            [application endBackgroundTask:bgTask];
            
        });
        
    }];
    
    [self stopTimer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self uploadEvent];
        });
    });
    
    
}

//重新进来后响应
- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self startTimer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self uploadEvent];
    });
}

//// 杀死程序
- (void)applicationWillTerminateNotification:(NSNotification *)notification
{
    MW_ConnectionSessionManager *sessionManager = [MW_ConnectionSessionManager sharedInstance];
    sessionManager.willTerminate = YES;
    [self uploadEvent];
}

- (void)dealloc
{
    [self stopTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
