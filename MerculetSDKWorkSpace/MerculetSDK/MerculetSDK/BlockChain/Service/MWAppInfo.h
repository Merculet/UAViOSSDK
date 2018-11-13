//
//  MWAppInfo.h
//  MagicWindowSampleApp
//
//  Created by 刘家飞 on 16/4/27.
//  Copyright © 2016年 MagicWindow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWAppInfo : NSObject

- (NSDictionary *)getAppInfo;
- (NSString *)getBundleID;
- (NSString *)getAppVersion;
- (NSString *)getSDKVersion;
- (NSString *)appFirstStartTime;
- (NSString *)getAppName;

@end
