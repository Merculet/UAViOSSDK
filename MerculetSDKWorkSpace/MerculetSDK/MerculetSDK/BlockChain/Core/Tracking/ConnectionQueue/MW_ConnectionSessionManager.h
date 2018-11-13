//
//  MW_ConnectionSessionManager.h
//  MerculetSDK
//
//  Created by 王大吉 on 25/4/2018.
//  Copyright © 2018 王伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MW_ConnectionSessionManager : NSObject

@property (nonatomic, assign) BOOL willTerminate;

- (void)initTokneWithUserOpenid: (nonnull NSString *)userObpenid;

- (void)recordCustomEventDic: (nonnull NSDictionary *)eventDic;

+ (nonnull id)sharedInstance;

- (void)tick;

@end
