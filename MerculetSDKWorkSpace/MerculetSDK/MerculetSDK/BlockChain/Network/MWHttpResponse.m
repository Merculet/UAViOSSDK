//
//  HttpResponse.m
//
//
//  Created by 刘家飞 on 16/8/3.
//  Copyright © 2016年 All rights reserved.
//

#import "MWHttpResponse.h"
#import "MWLog.h"
#import "MWAPI.h"
//#import "MWUncaughtExceptionHandler.h"

#define MW_RECEIVE_STATUS                       @"status"
#define MW_RECEIVE_CODE                         @"code"
#define MW_RECEIVE_ERROR_MESSAGE                @"message"
#define MW_RECEIVE_DATA                         @"data"

@implementation MWHttpResponse

+ (BOOL)statusOK:(id)responseObj
{
    @try {
        if (![responseObj isKindOfClass:[NSDictionary class]])
        {
            return NO;
        }
        
        NSDictionary *responseDic = (NSDictionary *)responseObj;
        
        id statusObj = [responseDic objectForKey:MW_RECEIVE_STATUS];
        
        if (statusObj == nil)
        {
            statusObj = [responseDic objectForKey:MW_RECEIVE_CODE];
        }
        
        if (statusObj == nil) return NO;
//        
//        [self pushTokenExpired:@(998) message:@"test"];
//        return NO;
        
        NSInteger status = [statusObj integerValue];
        if (status != 0)
        {
            NSString *errorMsg = [responseDic objectForKey:MW_RECEIVE_ERROR_MESSAGE];
            if (errorMsg != nil)
            {
                [MWLog log:[NSString stringWithFormat:@"errorMessage = %@",errorMsg]];
            }
            else
            {
                [MWLog log:[NSString stringWithFormat:@"status = %li",(long)status]];
            }
            [self pushTokenExpired:status message:errorMsg];
            return NO;
        }
        return YES;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

+ (BOOL)isOk:(id)responseObj Class:(Class)aClass
{
    @try {
        
        // 服务器返回不正常
        if (![MWHttpResponse statusOK:responseObj])
        {
            return NO;
        }
        
        // 获取的信息为空的时候
        id adObject = [(NSDictionary *)responseObj objectForKey:MW_RECEIVE_DATA];
        
        // adObject为nil或者adObject的值为空
        if (adObject == nil || [adObject isKindOfClass:[NSNull class]])
        {
            return NO;
        }
        
        // 针对返回的adObject都需要验证他的类型
        if (aClass != nil && ![adObject isKindOfClass:aClass])
        {
            return NO;
        }
        
        return YES;
    } @catch (NSException *exception) {

    } @finally {
        
    }
}

+ (id)responseData:(id)responseObj
{
    @try {
        NSDictionary *responseDic = (NSDictionary *)responseObj;
        id obj = [responseDic objectForKey:MW_RECEIVE_DATA];
        if ([obj isKindOfClass:[NSNull class]])  return nil;
        return obj;
    } @catch (NSException *exception) {

    } @finally {
        
    }
}

+ (void)pushTokenExpired:(NSInteger)code message:(NSString *)message {
    @try {
        if (code == 998 || code == 999) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:@(code) forKey:MW_RECEIVE_CODE];
            if (message != nil && message.length != 0) {
                [userInfo setValue:message forKey:MW_RECEIVE_ERROR_MESSAGE];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:MWTokenExpiredNotification object:self userInfo:userInfo];
        }
    } @catch(NSException *exception) {
        
    } @finally {
        
    }
}

@end
