//
//  MWRealTimeManager.h
//  MerculetSDK
//
//  Created by 王大吉 on 1/8/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWAPI.h"

@interface MWRealTimeOperationManager : NSObject

- (void)setRealTimeCustomAction:(nonnull NSString *)action
                      originParameter:(nullable NSDictionary *)originParameter
                      parameter:(nullable NSDictionary *)parameter;

@end
