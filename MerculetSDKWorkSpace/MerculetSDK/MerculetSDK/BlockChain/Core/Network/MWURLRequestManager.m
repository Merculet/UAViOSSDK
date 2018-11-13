//
//  MWURLRequestManager.m
//  
//
//  Created by 刘家飞 on 14/12/29.
//  Copyright (c) 2014年 All rights reserved.
//

#import "MWURLRequestManager.h"
#import "MWLog.h"
//#import "MWNSStringUtils.h"
#import "MWReachability.h"
//#import "MWUncaughtExceptionHandler.h"
//#import "MWDictionaryUtils.h"

#define TIME_OUT                        20
#define RE_TRY                          1       //重试机制，重试2次，一共请求3次

@interface MWURLRequestManager ()<NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation MWURLRequestManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //        self.session = [NSURLSession sharedSession];
        //        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    }
    return self;
}

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLResponse *, id, NSData *))success
     failure:(void (^)(NSURLResponse *, NSError *))failure
{
    [self POST:URLString headers:nil parameters:parameters success:success failure:failure];
}

- (void)POST:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters
     success:(void (^)(NSURLResponse *, id, NSData *))success
     failure:(void (^)(NSURLResponse *, NSError *))failure
{
    @try {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            if([MWReachability getNetworkStatus] == NotReachable)
            {
                [MWLog log:@"###no network" ];
                NSError *error = [NSError errorWithDomain:@"merculetwindow.noNetwork" code:0 userInfo:@{@"localizedDescription":@"no network"}];
                failure(nil,error);
                return;
            }
            
            if (parameters == nil) return;
            NSMutableURLRequest *request = [self preparePostRequest:URLString Headers:headers parameters:parameters];
            [self POST:request RetryingNumberOfTimes:RE_TRY success:success failure:failure];
        });
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (NSMutableURLRequest *)preparePostRequest:(NSString *)urlString Headers:(NSDictionary *)headers parameters:(id)parameters
{
    @try {
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIME_OUT];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        //header
        if (headers != nil)
        {
            [headers.allKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (headers[obj] != nil)
                {
                    [request addValue:headers[obj] forHTTPHeaderField:obj];
                }
            }];
            [MWLog log:[NSString stringWithFormat:@"url = %@,header = %@",url,request.allHTTPHeaderFields]];
        }
        
        
        if ([parameters isKindOfClass:[NSDictionary class]])
        {
//            parameters = [MWDictionaryUtils reviewDic:parameters];
        }
        
        if ([NSJSONSerialization isValidJSONObject:parameters])
        {
//            NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
//            [request setHTTPBody:postData];
            NSString *parseParamsResult =[self jsonString:parameters];
            [MWLog log:[NSString stringWithFormat:@"%@",parseParamsResult]];
            NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:postData];
        }
        return request;
        
    }@catch (NSException *exception) {
         // [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"preparePostRequest:"];
    } @finally {
        
    }
}

- (NSString *)jsonString:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        object = [self reviewDic:object];
    }
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:object options:0 error:nil] encoding:NSUTF8StringEncoding];
}

- (NSMutableDictionary *)reviewDic:(NSDictionary *)dic
{
    if ([dic isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    if (dic == nil || dic.count == 0)
    {
        return [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    NSMutableDictionary *oldDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSMutableDictionary *newDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [oldDic.allKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        id value = [oldDic objectForKey:obj];
        if (value == [NSNull null])
        {
            [newDic removeObjectForKey:obj];
        }
    }];
    return newDic;
}

- (void)POST:(NSURLRequest *)request RetryingNumberOfTimes:(NSUInteger)ntimes
     success:(void (^)(NSURLResponse *, id, NSData *))success
     failure:(void (^)(NSURLResponse *, NSError *))failure
{
    @try {

        if (ntimes < 1) return;
 
        __block NSUInteger retringNum = ntimes;
        if (self.session == nil)
        {
            //NSURLSessionConfiguration 设置成ephemeralSessionConfiguration，否则iOS8.1.0以下会有一个bug
            self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration] delegate:self  delegateQueue:[NSOperationQueue currentQueue]];
        }
        
        //        NSURLSession *session = [NSURLSession sharedSession];
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.session != nil)
            {
                [strongSelf.session invalidateAndCancel];
                strongSelf.session = nil;
            }
            
            if (error)
            {
                [MWLog log:[NSString stringWithFormat:@"error = %@",error.userInfo]];
                if (ntimes == 1)
                {
                    failure(response,error);
                }
                else
                {
                    retringNum --;
                    [strongSelf POST:request RetryingNumberOfTimes:retringNum success:success failure:failure];
                }
            }
            else
            {
                NSError *error = nil;
                if (data == nil || [data isKindOfClass:[NSNull class]])
                {
                    if (ntimes == 1)
                    {
                        failure(response,error);
                    }
                    else
                    {
                        retringNum --;
                        [strongSelf POST:request RetryingNumberOfTimes:retringNum success:success failure:failure];
                    }
                    return ;
                }
                id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (object == nil)
                {
                    if (ntimes == 1)
                    {
                        failure(response,error);
                    }
                    else
                    {
                        retringNum --;
                        [strongSelf POST:request RetryingNumberOfTimes:retringNum success:success failure:failure];
                    }
                    return;
                }
                [MWLog log:@"success"];
                success(response,object,data);
            }
        }];
        
        [task resume];
        
    } @catch (NSException *exception) {
         // [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"POST:"];
    } @finally {
        
    }
}

- (void)GET:(NSString *)urlString success:(void (^)(NSURLResponse *, id, NSData *))success failure:(void (^)(NSURLResponse *, NSError *))failure
{
    @try {
        
        [self GET:urlString headers:nil success:success failure:failure];
        
    } @catch (NSException *exception) {
         // [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"GET:"];
    } @finally {
        
    }
}

- (void)GET:(NSString *)urlString headers:(NSDictionary *)headers success:(void (^)(NSURLResponse *, id, NSData *))success failure:(void (^)(NSURLResponse *, NSError *))failure
{
    @try {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIME_OUT];
            [request setHTTPMethod:@"GET"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            //header
            if (headers != nil)
            {
                [headers.allKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if (headers[obj] != nil)
                    {
                        [request addValue:headers[obj] forHTTPHeaderField:obj];
                    }
                }];
            }
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error == nil)
                {
                    NSError *dataError = nil;
                    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&dataError];
                    success(response,object,data);
                }
                else
                {
                    failure(response,error);
                }
            }];
            [dataTask resume];
        });
        
    } @catch (NSException *exception) {
         // [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"GET:headers:"];
    } @finally {
    }
}

- (void)dealloc
{
    if (self.session != nil)
    {
        [self.session invalidateAndCancel];
        self.session = nil;
    }
}

#pragma mark NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        NSURLCredential *cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,cre);
    }
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error
{
    if (self.session != nil)
    {
        [self.session invalidateAndCancel];
        self.session = nil;
    }
}


@end
