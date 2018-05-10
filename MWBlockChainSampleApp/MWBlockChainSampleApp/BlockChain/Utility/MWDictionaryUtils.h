//
//  MWDictionaryUtils.h
//
//
//  Created by 刘家飞 on 15/1/16.
//  Copyright (c) 2015年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWDictionaryUtils : NSObject

+ (NSMutableDictionary *)reviewDic:(NSDictionary *)dic;

+ (id)reValue:(id)valueObj;

// 字典转json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;


@end
