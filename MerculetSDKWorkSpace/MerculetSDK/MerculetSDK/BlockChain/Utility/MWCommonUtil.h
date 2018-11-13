//
//  MWCommonUtil.h
//
//
//  Created by 刘家飞 on 16/8/5.
//  Copyright © 2016年 All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "MWUncaughtExceptionHandler.h"

// 判空操作
#define Value(X)                            X == nil ? @"" : X
#define Value_class(X)                      X == nil ? [NSNull null] : X

@interface MWCommonUtil : NSObject

+ (BOOL)isNotBlank:(nullable id)obj;

+ (BOOL)isBlank:(nullable id)obj;

//+ (void)openURL:(nonnull NSURL*)url completionHandler:(void (^ __nullable)(BOOL success))completion;

@end
