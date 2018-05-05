//
//  MWCompositeEvent.h
//
//
//  Created by 刘家飞 on 15/1/10.
//  Copyright (c) 2015年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWCompositeEvent : NSObject

    // 将事件添加配置信息
- (NSDictionary *)getCompositeEventDicWithEvents:(NSArray *)events;


+ (NSDictionary *)getLoginToken;

// 开发者是否传入用户数据
+ (BOOL)isUserLogin;

@end
