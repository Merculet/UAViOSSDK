//
//  MMA_ConnectionSession.m
//  MobileTracking
//
//  Created by shenjun.zhang on 12-10-15.
//  Copyright (c) 2012年 admaster. All rights reserved.
//

// 归档路径
#define TRACKING_CommonQUEUE                      @"magicwindow.tracking.queue"
#define TRACKING_CustomQUEUE                      @"magicwindow.tracking.queue1"

#import "MW_ConnectionSession.h"
#import "MWNSKeyedArchiverUtils.h"
#import "MWURLRequestManager.h"
#import "MWRequestOperation.h"
#import "MWCompositeEvent.h"
#import "MWCommonUtil.h"
#import "MWLog.h"
#import "MWReachability.h"
#import "MWCommonService.h"

#define MAX_COUNT           5000    //设置发送tracking数据requestlist的阀值

@interface MW_ConnectionSession()<MWRequestOperationDelegate>
{
    NSUInteger _sendSize;
}

@property (nonatomic,strong) NSMutableArray *eventList;
@property (nonatomic,strong) NSOperationQueue *sendQueue;
@property (nonatomic,strong) NSMutableArray *requestList;

@end

@implementation MW_ConnectionSession

//static MW_ConnectionSession *s_sharedConnectionQueue = nil;

//+ (MW_ConnectionSession *)sharedInstance
//{
//    if (s_sharedConnectionQueue == nil)
//    {
//        s_sharedConnectionQueue = [[MW_ConnectionSession alloc] init];
//    }
//    
//    return s_sharedConnectionQueue;
//}

- (instancetype)initWithType:(MW_ConnectionSessionType)type
{
	if (self = [super init])
	{
        self.type = type;
        self.eventList = [[NSMutableArray alloc] init];
        self.requestList = [[NSMutableArray alloc] init];
        self.sendQueue = [[NSOperationQueue alloc]init];
        [self.sendQueue setMaxConcurrentOperationCount: 1];
    }
	return self;
}


// 获取归档路径
- (NSString *)getPath {
    if (_type == MW_ConnectionSessionCustom) {
        return TRACKING_CustomQUEUE;
    }
    if (_type == MW_ConnectionSessionCustom) {
        return TRACKING_CommonQUEUE;
    }
    return @"";
}

- (void) tick
{
    @try {
        
//        [MWLog logForDev:[[MWCommonService sharedInstance] getuserOpenid]];
//        if (![[MWCommonService sharedInstance] getuserOpenid].length) {
//            // 不存在用户，将动作删除
//            [self.eventList removeAllObjects];
//            return;
//        }
        
            @synchronized(self)
            {
                if ([MWCommonUtil isNotBlank:self.eventList])
                {
                    NSArray *list = [self.eventList mutableCopy];
                    [self.eventList removeAllObjects];
                    NSDictionary *paramDic = [self getRequestParamDicWithEvents:list];
                    if ([MWCommonUtil isNotBlank:paramDic])
                    {
                        [self.requestList addObject:paramDic];
                        [self ensureRequestListsWithMethodName:@"tick 1"];
                    }
                }
                
                if([MWReachability getNetworkStatus] == NotReachable || _willTerminate)
                {
                    [MWLog log:@"###no network" ];
                    
                    if ([self requestCount] > 0)
                    {
                        [self queuePersistent];
                        [MWLog log:@"### 存储持久化的网络请求"];
                    }
                    return;
                }
                
                NSArray *localList = [self getArrayFromArchive: [self getPath]];
                if ([MWCommonUtil isNotBlank:localList])
                {
                    [self.requestList addObjectsFromArray: localList];
                    [MWNSKeyedArchiverUtils clearArchive: [self getPath]];
                    [self ensureRequestListsWithMethodName:@"tick 2"];
                }
                
                //list
                [self sendList];
                
            }
        
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"tick"];
    } @finally {
        
    }
    
}

- (void)sendList
{
    @try {
        @synchronized(self)
        {
            [self ensureRequestListsWithMethodName:@"sendList"];
            while([self requestCount] > 0 && [MWReachability getNetworkStatus] != NotReachable)
            {
                [self.requestList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([MWCommonUtil isNotBlank:obj])
                    {
                        [self sendurllocal:obj];
                    }
                }];
                [self.requestList removeAllObjects];
            }
        }
        
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"sendList"];
    } @finally {
        
    }
}

//为了更改以下bug，暂时特殊处理
//*** -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[1]
// __32-[MW_ConnectionSession sendList]_block_invoke (in LuoJiFMIOS) + 160
- (void)ensureRequestListsWithMethodName:(NSString *)name
{
    @try {
        if (self.requestList.count > 1 && self.requestList[1] == nil)
        {
//            NSString *str = [self.requestList componentsJoinedByString:@","];
            [self.requestList removeAllObjects];
//            NSException *exception = [NSException exceptionWithName:@"mw objects[1] is nil" reason:str userInfo:nil];
//            [MWUncaughtExceptionHandler mwSDKTrackingException:exception WithMethodName:name];
        }
    } @catch (NSException *exception) {

    } @finally {
        
    }
    
}

- (NSDictionary *)getRequestParamDicWithEvents:(NSArray *)eventList
{
    @try {
        MWCompositeEvent *comEvent = [[MWCompositeEvent alloc] init];
        return [comEvent getCompositeEventDicWithEvents:eventList];
    } @catch (NSException *exception) {

    } @finally {
        
    }
}

- (void)sendurllocal:(NSDictionary *)paramDic
{
    @try {
        MWRequestOperation * operation = [[MWRequestOperation alloc] initWithParamDic:paramDic delegate:self];
        [self.sendQueue addOperation:  operation];
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"sendurllocal:"];
    } @finally {
        
    }
}

- (void)recordEventDic:(NSDictionary *)event
{
    @try {
        @synchronized (self) {
            if ([MWCommonUtil isNotBlank:event])
            {
                [self.eventList addObject: event];
                
//                MWStrategyConfig *mwConfig = [MWStrategyConfig sharedInstance];
//                MWSendConfig *sendConfig = mwConfig.sendConfig;
//                _sendSize = sendConfig.batchSize;
                _sendSize = 30;
//                _sendSize = 5;
                
                [MWLog log:[NSString stringWithFormat:@"点击事件数量：%lu",(unsigned long)[self eventsCount]] ];
                if ([self eventsCount] >= _sendSize)
                {
                    [self tick];
                }
            }
        }
        
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"recordEvenDic:"];
    } @finally {
        
    }
}

-(NSUInteger) eventsCount
{
    @try {
            return [self.eventList count];
        
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"eventsCount"];
    } @finally {
        
    }
}

- (NSUInteger)requestCount
{
    @try {
        return [self.requestList count];
        
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"requestCount"];
    } @finally {
        
    }
}

-(void )writeArray:(NSMutableArray *)array ToArchive:(NSString *)path
{
    @try {
        @synchronized(self)
        {
            NSMutableArray *list = [array mutableCopy];
            [array removeAllObjects];
            if (list.count > MAX_COUNT)
            {
                [list removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(MAX_COUNT, array.count-MAX_COUNT)]];
            }
            
            [MWNSKeyedArchiverUtils archiveObject:list toPath:path];
        }
        
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"writeArray:ToArchive:"];
    } @finally {
        
    }
}

-(NSArray *)getArrayFromArchive:(NSString *)path
{
    NSArray *arr =  [MWNSKeyedArchiverUtils unarchiveObjectWithPath:path];
    return arr;
}

- (void) queuePersistent
{
    //TODO*** -[NSFileManager fileSystemRepresentationWithPath:]: unable to allocate memory for length (1072) (magicWindow queuePersistent)
    @try {
        [MWLog log:@"##queuePersistent"];
        
        // 将新事件添加在本地数据之后
        
        NSArray *archiveArr = [self getArrayFromArchive: [self getPath] ];
        if (archiveArr != nil)
        {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:archiveArr];
            [arr addObjectsFromArray: _requestList];
            self.requestList = arr;
            [self ensureRequestListsWithMethodName:@"queuePersistent"];
        }
        
        [MWNSKeyedArchiverUtils clearArchive: [self getPath]];
        [self writeArray: self.requestList ToArchive: [self getPath]];
        
        [self.requestList removeAllObjects];
    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"queuePersistent"];
    } @finally {
        
    }
}

#pragma mark - RequestOperationDelegate
-(void)requestSuccess:(MWRequestOperation *)oper withParamDic:(NSDictionary *)paramDic
{
    if ([self.requestList containsObject:paramDic]) {
        [self.requestList removeObject:paramDic];
    }
}

-(void)requestFail:(MWRequestOperation *)oper withParamDic:(NSDictionary *)paramDic
{
    if ([MWCommonUtil isNotBlank:paramDic])
    {
        [self.requestList addObject:paramDic];
    }
}



- (void)dealloc
{
    [MWLog log:@"##connectionSession dealloc"];
    [self queuePersistent];
}

@end
