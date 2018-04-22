//
//  MWTimerManager.m
//
//
//  Created by 刘家飞 on 16/7/18.
//  Copyright © 2016年 All rights reserved.
//

#import "MWTimerManager.h"
//#import "MWUncaughtExceptionHandler.h"

@interface MWTimerManager ()

@property (nonatomic, strong) NSMutableDictionary *timerContainer;
@property (nonatomic, strong) NSMutableDictionary *actionBlockCache;

@end

@implementation MWTimerManager

+ (MWTimerManager *)shareInstance
{
    static MWTimerManager *timerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timerManager = [[self alloc] init];
    });
    return timerManager;
}

- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                          actionOption:(MWActionOption)option
                                action:(dispatch_block_t)action
{
    @try {
        
        if (nil == timerName)
            return;
        
        if (nil == queue)
            queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
        if (!timer) {
            timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_resume(timer);
            if (timer == nil)  return;
            [self.timerContainer setObject:timer forKey:timerName];
        }
        
        /* timer精度为0.1秒 */
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);

        switch (option) {
                
            case MWAbandonPreviousAction:
            {
                /* 移除之前的action */
                [self removeActionCacheForTimer:timerName];
                
                dispatch_source_set_event_handler(timer, ^{
                    action();
                    
                    if (!repeats) {
                        [self cancelTimerWithName:timerName];
                    }
                });
            }
                break;
                
            case MWMergePreviousAction:
            {
                /* cache本次的action */
                [self cacheAction:action forTimer:timerName];
                
                dispatch_source_set_event_handler(timer, ^{
                    NSMutableArray *actionArray = [self.actionBlockCache objectForKey:timerName];
                    [actionArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        dispatch_block_t actionBlock = obj;
                        if (actionBlock != nil)
                        {
                            actionBlock();
                        }
                    }];
                    [self removeActionCacheForTimer:timerName];
                    
                    if (!repeats) {
                        [self cancelTimerWithName:timerName];
                    }
                });
            }
                break;
        }

    } @catch (NSException *exception) {
        // [MWUncaughtExceptionHandler mwSDKException:exception  WithMethodName:@"scheduledDispatchTimerWithName:"];
    } @finally {
    }
}

- (void)cancelTimerWithName:(NSString *)timerName
{
    @try {
        dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
        
        if (!timer) {
            return;
        }
        
        [self.timerContainer removeObjectForKey:timerName];
        dispatch_source_cancel(timer);
        
        [self.actionBlockCache removeObjectForKey:timerName];
    } @catch (NSException *exception) {
        // [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"cancelTimerWithName:"];
    } @finally {
        
    }
}

- (void)cancelAllTimer
{
    @try {
        // Fast Enumeration
        [self.timerContainer enumerateKeysAndObjectsUsingBlock:^(NSString *timerName, dispatch_source_t timer, BOOL *stop) {
            [self.timerContainer removeObjectForKey:timerName];
            dispatch_source_cancel(timer);
        }];
    } @catch (NSException *exception) {
        // [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"cancelAllTimer"];
    } @finally {
        
    }
}

#pragma mark - Property

- (NSMutableDictionary *)timerContainer
{
    if (!_timerContainer) {
        _timerContainer = [[NSMutableDictionary alloc] init];
    }
    return _timerContainer;
}

- (NSMutableDictionary *)actionBlockCache
{
    if (!_actionBlockCache) {
        _actionBlockCache = [[NSMutableDictionary alloc] init];
    }
    return _actionBlockCache;
}

#pragma mark - Private Method

- (void)cacheAction:(dispatch_block_t)action forTimer:(NSString *)timerName
{
    @try {
        id actionArray = [self.actionBlockCache objectForKey:timerName];
        
        if (actionArray && [actionArray isKindOfClass:[NSMutableArray class]]) {
            [(NSMutableArray *)actionArray addObject:action];
        }else {
            NSMutableArray *array = [NSMutableArray arrayWithObject:action];
            [self.actionBlockCache setObject:array forKey:timerName];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)removeActionCacheForTimer:(NSString *)timerName
{
    if (![self.actionBlockCache objectForKey:timerName])
        return;
    
    [self.actionBlockCache removeObjectForKey:timerName];
}

@end
