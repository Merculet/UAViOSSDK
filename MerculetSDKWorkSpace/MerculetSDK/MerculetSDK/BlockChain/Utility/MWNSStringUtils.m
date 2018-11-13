//
//  MWNSStringUtils.m
//
//
//  Created by 刘家飞 on 14/11/5.
//  Copyright (c) 2014年 All rights reserved.
//

#import "MWNSStringUtils.h"
#import <CommonCrypto/CommonDigest.h>
//#import "MWDictionaryUtils.h"
#import <UIKit/UIKit.h>

@implementation MWNSStringUtils

+ (NSString *)createNewUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef string = CFUUIDCreateString(kCFAllocatorDefault, theUUID);
    CFRelease(theUUID);
    NSString *uuidStr = (NSString *)CFBridgingRelease(string);
    return [uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (NSString *)createRandomNum
{
    NSString *random = @"";
    for(int i=0; i < 4; i++)
    {
        random = [random stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    return random;
}

//MD5 32位加密（小写）
+ (NSString *)MD5TO32Lower:(NSString *)mwstr
{
    const char *cStr = [mwstr UTF8String];
    
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]];
}

//MD5 16位加密（小写)
+(NSString *)MD5TO16Lower:(NSString *)mwstr
{
    //先32位加密
    NSString *str = [self MD5TO32Lower:mwstr];
    //取中间16位
    return [str substringWithRange:NSMakeRange(8, 16)];
}

//+ (NSString *)jsonString:(id)object
//{
//    if ([object isKindOfClass:[NSDictionary class]])
//    {
//        object = [MWDictionaryUtils reviewDic:object];
//    }
//    else
//    {
//        return @"";
//    }
//    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:object options:0 error:nil] encoding:NSUTF8StringEncoding];
//}

//TODO 新增
//+ (BOOL)string:(NSString *)string hasContainsString:(NSString *)str
//{
//    if([[[UIDevice currentDevice]systemVersion] floatValue]>7.9)
//    {
//        return [string containsString:str];
//    }
//    else
//    {
//        if ([string rangeOfString:str options:NSLiteralSearch | NSNumericSearch].location != NSNotFound)
//        {
//            return YES;
//        }
//        else
//        {
//            return NO;
//        }
//    }
//}

@end
