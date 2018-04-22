//
//  MWRequestOperation.m
//  MWBlockChain
//
//  Created by 王伟 on 2018/3/12.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import "MWRequestOperation.h"
#import "MWURLRequestManager.h"
#import "MWHttpResponse.h"
#import "MWBlockChainDefine.h"
#import "MWCompositeEvent.h"
#import "MWDictionaryUtils.h"
#import "MWLog.h"
#import "MWCommonUtil.h"

#define EVENT_REQUEST_KEY       @"EVENT_REQUEST_KEY"

static NSDictionary *_tokenDic;

@interface MWRequestOperation()

@property (nonatomic,retain) NSDictionary *paramDic;

@end

@implementation MWRequestOperation

#pragma mark -
#pragma mark - Public
- (id)initWithParamDic:(NSDictionary *)paramDic delegate:(id<MWRequestOperationDelegate>)delegate
{
    if (self = [super init])
    {
        _paramDic = paramDic;
        _delegate = delegate;
    }
    return self;
}

- (void)main
{
    @try {
        @autoreleasepool
        {
            if (self.isCancelled)
            {
                return;
            }
            // 进行网络请求
            [self gotoAction];
        }
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"main"];
    } @finally {
        
    }
}

- (void)gotoAction {
    

    NSString *urlString = [MW_RELEASE stringByAppendingString:MW_TRACKING_URL];
    MWURLRequestManager *manager = [[MWURLRequestManager alloc] init];
    NSDictionary *headers = [self headers];
    if ([MWCommonUtil isBlank:headers])  {
        
        [self newToken];
        return;
        
    }
    [manager POST:urlString headers:headers parameters:_paramDic success:^(NSURLResponse *response, id responseObject, NSData *data) {
            
            // 检测token是否失效
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                id statusObj = [responseObject objectForKey:@"code"];
                NSInteger status = [statusObj integerValue];
                if (status == 1) {
                    // 重新获取token后
//                    [MWLog logcurrentThread];
                    [self newToken];
                    return;
                }
            }
        
            if (![MWHttpResponse statusOK:responseObject])
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(requestFail:withParamDic:)])
                {
                    [self.delegate requestFail:self withParamDic:_paramDic];
                }
                return ;
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestSuccess:withParamDic:)])
            {
                [self.delegate requestSuccess:self withParamDic:_paramDic];
            }
            
        } failure:^(NSURLResponse *response, NSError *error) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestFail:withParamDic:)])
            {
                [self.delegate requestFail:self withParamDic:_paramDic];
            }
        }];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_paramDic forKey:EVENT_REQUEST_KEY];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _paramDic = [aDecoder decodeObjectForKey:EVENT_REQUEST_KEY];
    }
    return self;
}

- (NSDictionary *)headers {
    
    if ([MWCommonUtil isNotBlank:_tokenDic]) {
        return _tokenDic;
    } else {
        NSString *token = [[MWCommonService sharedInstance] getMWToken];
        if (token.length) {
            NSDictionary *dic = @{@"mw-token" : token};
            _tokenDic = dic;
            return _tokenDic;
        } else {
            return nil;
        }
    }
}

// 请求最新的token
- (void)newToken {

    [MWLog logcurrentThread];
    
    NSDictionary *dic = [MWCompositeEvent getLoginToken];
    NSString *urlString = [MW_RELEASE stringByAppendingString:MW_Login_Token_API];
    MWURLRequestManager *manager = [[MWURLRequestManager alloc] init];
    [manager POST:urlString parameters:dic success:^(NSURLResponse *response, id responseObject, NSData *data) {
        
        [MWLog logcurrentThread];
        
        // 将token保存下来
        if (![MWHttpResponse statusOK:responseObject])
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestFail:withParamDic:)])
            {
                [self.delegate requestFail:self withParamDic:_paramDic];
            }
            return ;
        }
        
        @try {
            [[MWCommonService sharedInstance] saveAndUpdateMWToken:Value([responseObject objectForKey:@"data"])];
            // token请求到了 进行请求
            NSString *string = [responseObject objectForKey:@"data"];
            if (string.length) {
                NSDictionary *dic = @{@"mw-token" : Value(string)};
                _tokenDic = dic;
                [self gotoAction];
            }
        }@catch(NSException *exception) {
            
        }
        
        
    } failure:^(NSURLResponse *response, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestFail:withParamDic:)])
        {
            [self.delegate requestFail:self withParamDic:_paramDic];
        }
    }];
}

@end
