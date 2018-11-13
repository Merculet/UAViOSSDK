//
//  MWRealTimeManager.m
//  MerculetSDK
//
//  Created by 王大吉 on 1/8/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import "MWRealTimeOperationManager.h"
#import "MWCompositeEvent.h"
#import "MWCommonUtil.h"
#import "MWDictionaryUtils.h"
#import "MWLog.h"
#import "MWURLService.h"
#import "MWPostServiceKey.h"
#import "MWURLRequestManager.h"
#import "MWHttpResponse.h"
#import "MWAPI.h"

@implementation MWRealTimeOperationManager


- (void)setRealTimeCustomAction:(nonnull NSString *)action
                originParameter:(nullable NSDictionary *)originParameter
                     parameter:(nullable NSDictionary *)parameter  {
    @try {
        // 发送新的事件
        NSMutableArray *eventList = [[NSMutableArray alloc] init];
        [eventList addObject: parameter];
        
        MWCompositeEvent *comEvent = [[MWCompositeEvent alloc] init];
        NSDictionary *dic = [comEvent getCompositeEventDicWithEventsNoUser:eventList];
        
        NSString *jsonString = [MWDictionaryUtils dictionaryToJson:dic];
        NSDictionary *headers = [[[MWCompositeEvent alloc] init] headersWithParams:jsonString];
        
        if ([MWCommonUtil isBlank:headers] || [MWCommonUtil isBlank:jsonString]) {return;}
        
        /// body
        NSDictionary *bodyParam = @{MW_POST_KEY_EVENT_MW_INFO: jsonString};
        
        /// url
        NSString *urlString = [MWURLService urlTrackingURL];
        
        [[MWURLRequestManager alloc] POST:urlString
                                  headers:headers
                               parameters:bodyParam
                                  success:^(NSURLResponse *response, id responseObject, NSData *data) {
                                      
                                      int code = [MWHttpResponse getResponseCode:responseObject];
//                                      NSString *message = [MWHttpResponse getResponseMessage:responseObject];
                                      
                                      if (code == 0) {
//                                          successBlock();
                                      } else {
                                          [MWAPI event:action attributes:originParameter];
                                      }
                                  } failure:^(NSURLResponse *response, NSError *error) {
                                      [MWAPI event:action attributes:originParameter];
                                  }];
    } @catch (NSException *exception) {
    } @finally {
    }
}


@end
