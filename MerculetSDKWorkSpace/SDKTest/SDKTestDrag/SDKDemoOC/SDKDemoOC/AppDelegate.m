//
//  AppDelegate.m
//  MerculetSDKDemo
//
//  Created by 王大吉 on 14/5/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import "AppDelegate.h"
#import "MWToast.h"

//#import <MerculetSDK/MWAPI.h>
#import <MagicWindowUAVSDK/MWAPI.h>
//#import <MagicWindowUAVSDKBitcode/MWAPI.h>
//#import <MerculetSDK/MWAPI.h>
//#import <MerculetSDKBitcode/MWAPI.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册
    [MWAPI registerApp];
    
    // log
    [MWAPI showLogEnable:YES];
    
    // token失效
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pushTokenExpired)
                                                 name:MWTokenExpiredNotification
                                               object:nil];
    
    // 实时的回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pushTokenRealTimeExpired:)
                                                 name:MWTokenExpiredNotification
                                               object:nil];
    
    return YES;
}

- (void)pushTokenExpired {
    NSLog(@"token 失效");
}

- (void)pushTokenRealTimeExpired:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSLog(@"%@",userInfo);
    [MWToast toastString:[NSString stringWithFormat:@"%@",userInfo]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
