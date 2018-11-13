//
//  MWLog.m
//  youth2
//
//  Created by shenjun on 14-5-28.
//  Copyright (c) 2014年 sunnyshine. All rights reserved.
//

#import "MWLog.h"

@implementation MWLog

static bool theDebug  = NO;
static bool logEnable = NO;

+ (void) setDebug:(BOOL)debug
{
    theDebug = debug;
}

+(void) log:(NSString *) logStr
{
    
    if (theDebug)
    {
        NSLog(@"merculet log: %@",logStr);
    }
}

+(void)logcurrentThread
{
    
    if (theDebug)
    {
        NSLog(@"merculet log currentThread: %@",[NSThread currentThread]);
    }
}

+(void) log:(NSString *) pattern withParameters:(id)parameter, ...
{
    if (theDebug)
    {
        NSLog(pattern,parameter);
    }
}

// 为开发者展示的log
+ (void)setDevLogEnable:(BOOL)enable
{
    logEnable = enable;
}

+ (void)logForDev:(NSString *) logStr
{
    if (logEnable)
    {
        NSLog(@"merculet log: %@",logStr);
    }
}

@end
