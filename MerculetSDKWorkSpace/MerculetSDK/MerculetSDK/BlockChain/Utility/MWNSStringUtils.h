//
//  MWNSStringUtils.h
//
//
//  Created by 刘家飞 on 14/11/5.
//  Copyright (c) 2014年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWNSStringUtils : NSObject

// 生成新的UUID
+ (NSString *)createNewUUID;

//生成4位随机数
+ (NSString *)createRandomNum;

//MD5 32位加密（小写）
+ (NSString*)MD5TO32Lower:(NSString *)mwstr;

//MD5 16位加密（小写)
+ (NSString*)MD5TO16Lower:(NSString *)mwstr;

//+ (NSString *)jsonString:(id)object;

//判断string中是否包含str字符
+ (BOOL)string:(NSString *)string hasContainsString:(NSString *)str;


@end
