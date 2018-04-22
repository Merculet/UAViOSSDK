//
//  MMA_ConnectionSession.h
//  MobileTracking
//
//  Created by shenjun.zhang on 12-10-15.
//  Copyright (c) 2012年 admaster. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MW_ConnectionSessionNone,
    MW_ConnectionSessionCommon,
    MW_ConnectionSessionCustom,
} MW_ConnectionSessionType;

@interface MW_ConnectionSession : NSObject

//+ (MW_ConnectionSession *)sharedInstance;

- (instancetype)initWithType:(MW_ConnectionSessionType)type;
- (void)recordEventDic:(NSDictionary *)event;
- (void) tick;
- (NSUInteger) eventsCount;
- (NSUInteger)requestCount;
- (void) queuePersistent;

@property (nonatomic,assign) MW_ConnectionSessionType type;
@property (nonatomic,assign) BOOL willTerminate;

@end
