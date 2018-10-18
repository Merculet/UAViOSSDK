//
//  MWHTTPURLResponse.h
//  MerculetSDK
//
//  Created by 王大吉 on 2/8/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWHTTPURLResponse : NSHTTPURLResponse

@property (nonatomic, assign) int code;
@property (nonatomic, copy) NSString *message;

+ (instancetype)response:(NSString *)message code:(int)code;

@end
