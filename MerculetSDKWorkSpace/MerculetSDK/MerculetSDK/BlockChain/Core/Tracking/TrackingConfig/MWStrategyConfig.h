//
//  MWStrategyConfig.h
//  MerculetSDK
//
//  Created by 王大吉 on 30/7/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWSendConfig : NSObject

@property (nonatomic, assign) NSInteger batchSize;     //发送条数临界值
@property (nonatomic, assign) NSInteger period;        //发送时间间隔

@end

@interface MWStrategyConfig : NSObject

@property (nonatomic, strong) MWSendConfig *sendConfig;

+ (id)sharedInstance;

@end
