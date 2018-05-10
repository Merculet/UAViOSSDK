//
//  MWDictionaryUtils.m
//
//
//  Created by 刘家飞 on 15/1/16.
//  Copyright (c) 2015年 All rights reserved.
//

#import "MWDictionaryUtils.h"
#import "MWCommonUtil.h"

@implementation MWDictionaryUtils

//dictionaryRemoveNullValueKey
+ (NSMutableDictionary *)reviewDic:(NSDictionary *)dic
{
    if ([MWCommonUtil isBlank:dic])
    {
        return nil;
    }
    NSMutableDictionary *newDic = [dic mutableCopy];
    [dic.allKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        id value = [dic objectForKey:obj];
        if (value == [NSNull null])
        {
            [newDic removeObjectForKey:obj];
        }
    }];
    return newDic;
}

+ (id)reValue:(id)valueObj
{
    if ([valueObj isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    return valueObj;
}

// 字典转json格式字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
