//
//  MWCompositeEvent.h
//
//
//  Created by 刘家飞 on 15/1/10.
//  Copyright (c) 2015年 All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MWCompositeEvent : NSObject

// 将事件添加配置信息
- (NSDictionary *)getCompositeEventDicWithEvents:(NSArray *)events;

// 将事件添加配置信息, 没有userName字段
- (NSDictionary *)getCompositeEventDicWithEventsNoUser:(NSArray *)events;

// 获取网络请求的header
- (nullable NSMutableDictionary *)headersWithParams:(NSString *)jsonString;




//+ (nullable NSDictionary *)getLoginToken;

// 开发者是否传入用户数据
//+ (BOOL)isUserLogin;

@end

NS_ASSUME_NONNULL_END
