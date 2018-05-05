//
//  MWCommonUtil.m
//
//
//  Created by 刘家飞 on 16/8/5.
//  Copyright © 2016年 All rights reserved.
//

#import "MWCommonUtil.h"

#define ISIOS10     ([[[UIDevice currentDevice]systemVersion] floatValue]>9.9? 1:0)

@implementation MWCommonUtil

+ (BOOL)isNotBlank:(id)obj
{
//    @try {
    
        if (obj == nil)
        {
            return NO;
        }
        
        BOOL result = YES;
        if ([obj isKindOfClass:[NSNull class]])
        {
            result = NO;
        }
        else if ([obj isKindOfClass:[NSString class]])
        {
            NSString *str = (NSString *)obj;
            result = str.length>0 ? YES:NO;
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            NSArray *list = (NSArray *)obj;
            result = list.count>0 ? YES:NO;
        }
        else if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = (NSDictionary *)obj;
            result = dic.allKeys.count>0 ? YES:NO;
        }
        else if ([obj isKindOfClass:[NSURL class]])
        {
            NSURL *url = (NSURL *)obj;
            result = [url absoluteString].length > 0 ? YES : NO;
        }
        
        return result;
        
//    } @catch (NSException *exception) {
//
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"isNotBlank:"];
//
//    } @finally {
//
//    }
    
}

+ (BOOL)isBlank:(id)obj
{
    return ![MWCommonUtil isNotBlank:obj];
}

//+ (void)openURL:(nonnull NSURL*)url completionHandler:(void (^ __nullable)(BOOL success))completion
//{
//    if (@available(iOS 10.0, *))
//    {
//        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
//            if (completion != nil) completion(success);
//        }];
//    }
//    else
//    {
//        // Fallback on earlier versions
//        BOOL result = [[UIApplication sharedApplication] openURL:url];
//        if (completion != nil) completion(result);
//    }
//    
//}

@end
