//
//  HttpResponse.h
//
//
//  Created by 刘家飞 on 16/8/3.
//  Copyright © 2016年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWHttpResponse : NSObject

@property (nonatomic, assign) int code;
@property (nonatomic, copy) NSString *message;

+ (BOOL)statusOK:(id)responseObj;
+ (BOOL)isOk:(id)responseObj Class:(Class)aClass;
+ (id)responseData:(id)responseObj;

// 判断是否会JOSN解析code
+ (int)getResponseCode:(id)responseObj;

// 判断是否会JOSN解析message
+ (NSString *)getResponseMessage:(id)responseObj;


@end
