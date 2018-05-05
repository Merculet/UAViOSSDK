//
//  MWCommonActionManager.m
//  MWBlockChain
//
//  Created by 王伟 on 2018/3/13.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import "MWCommonActionManager.h"
#import <UIKit/UIKit.h>
#import "MW_ConnectionSessionManager.h"

@implementation MWCommonActionManager

+ (id)sharedInstance
{
    static MWCommonActionManager *sendManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sendManager = [[self alloc] init];
    });
    return sendManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground:)
//                                                     name:UIApplicationDidEnterBackgroundNotification object:nil];
//        //监听是否重新进入程序.
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
//                                                     name:UIApplicationDidBecomeActiveNotification object:nil];
//
//        // 程序被杀掉
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminateNotification:)
//                                                     name:UIApplicationWillTerminateNotification object:nil];
//
//        // 程序启动
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunchingNotification:)
//                                                     name:UIApplicationDidFinishLaunchingNotification object:nil];
    }
    return self;
}

//- (void)enterBackground:(NSNotification*)notification
//{
//    UIApplication *application = [UIApplication sharedApplication];
//    
//    __block UIBackgroundTaskIdentifier bgTask;
//    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
//        [application endBackgroundTask:bgTask];
//        bgTask = UIBackgroundTaskInvalid;
//    }];
//    
//     [self sendCommonEventWithAction:@{@"action":@"enterBackground"}];
//}
//
////重新进来后响应
//- (void)applicationDidBecomeActive:(NSNotification *)notification
//{
//    [self sendCommonEventWithAction:@{@"action":@"BecomeActive"}];
//}
//
////程序启动
//- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification
//{
//    [self sendCommonEventWithAction:@{@"action":@"BecomeActive"}];
//}
//
//// 程序被杀掉
//- (void)applicationWillTerminateNotification:(NSNotification *)notification
//{
//    [self sendCommonEventWithAction:@{@"action":@"WillTerminate"}];
//}
//
//
//// 发送事件
//- (void)sendCommonEventWithAction:(NSDictionary *)dic {
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[MW_ConnectionSessionManager sharedInstance] recordCommonEventDic:dic];
//    });
//}


@end
