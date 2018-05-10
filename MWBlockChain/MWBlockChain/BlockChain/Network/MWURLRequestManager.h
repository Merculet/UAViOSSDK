//
//  MWURLRequestManager.h
//
//
//  Created by 刘家飞 on 14/12/29.
//  Copyright (c) 2014年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWURLRequestManager : NSObject

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLResponse *response, id responseObject,NSData *data))success
     failure:(void (^)(NSURLResponse *response, NSError *error))failure;

- (void)POST:(NSString *)URLString
     headers:(NSDictionary *)headers parameters:(id)parameters
     success:(void (^)(NSURLResponse *response, id responseObject,NSData *data))success
     failure:(void (^)(NSURLResponse *response, NSError *error))failure;

- (void)GET:(NSString *)urlString
     success:(void (^)(NSURLResponse *response, id responseObject,NSData *data))success
     failure:(void (^)(NSURLResponse *response, NSError *error))failure;

- (void)GET:(NSString *)urlString headers:(NSDictionary *)headers
    success:(void (^)(NSURLResponse *response, id responseObject,NSData *data))success
    failure:(void (^)(NSURLResponse *response, NSError *error))failure;

@end
