//
//  MWLog.h
//  youth2
//
//  Created by shenjun on 14-5-28.
//  Copyright (c) 2014年 sunnyshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWLog : NSObject

+(void) setDebug:(BOOL)debug;

+(void) log:(NSString *) logStr;

+(void) log:(NSString *) pattern withParameters:(id)parameter, ...;

//为开发者展示的log
+ (void)setDevLogEnable:(BOOL)enable;

+ (void)logForDev:(NSString *) logStr;

+ (void)logcurrentThread;

@end
