//
//  MWToast.h
//  MerculetSDKDemo
//
//  Created by 王大吉 on 31/7/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWToast : NSObject

+ (void)toastString:(NSString *)text;

+ (void)toastFailureString:(NSString *)text;

@end
