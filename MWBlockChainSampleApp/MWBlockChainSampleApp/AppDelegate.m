//
//  AppDelegate.m
//  MWBlockChainSampleApp
//
//  Created by 王伟 on 2018/3/7.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import "AppDelegate.h"
#import <MerculetSDK/MWApi.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
        NSString * appkey = @"fb61da1dc41f4e1f8d978a9e7547edda";
        NSString * accountKey = @"4a0fa34013cc4ffba60c240ad7afe453";
        NSString * accountSecret = @"5838f70dbe2e4044a3fffd5d709f23c2";
    
    // 注册
    [MWAPI registerApp:appkey accountKey:accountKey accountSecret:accountSecret];
    
    return YES;
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
