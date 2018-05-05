//
//  HttpResponse.h
//
//
//  Created by 刘家飞 on 16/8/3.
//  Copyright © 2016年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWHttpResponse : NSObject

+ (BOOL)statusOK:(id)responseObj;
+ (BOOL)isOk:(id)responseObj Class:(Class)aClass;
+ (id)responseData:(id)responseObj;

@end
