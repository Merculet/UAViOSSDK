//
//  MWHTTPURLResponse.m
//  MerculetSDK
//
//  Created by 王大吉 on 2/8/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import "MWHTTPURLResponse.h"

@implementation MWHTTPURLResponse

+ (instancetype)response:(NSString *)message code:(int)code {
    MWHTTPURLResponse *response = [[MWHTTPURLResponse alloc] init];
    response.message = message;
    response.code = code;
    return response;
}

@end
