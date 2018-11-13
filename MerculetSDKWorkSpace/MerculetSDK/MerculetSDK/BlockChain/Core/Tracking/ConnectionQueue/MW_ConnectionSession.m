
//  MMA_ConnectionSession.m
//  MobileTracking
//
//  Created by shenjun.zhang on 12-10-15.
//  Copyright (c) 2012年 admaster. All rights reserved.
//

// 归档路径
#define TRACKING_CommonQUEUE                      @"merculet.tracking.queue"
#define TRACKING_CustomQUEUE                      @"merculet.tracking.queue1"

#import "MW_ConnectionSession.h"
#import "MWNSKeyedArchiverUtils.h"
#import "MWURLRequestManager.h"
#import "MWRequestOperation.h"
#import "MWCompositeEvent.h"
#import "MWCommonUtil.h"
#import "MWLog.h"
#import "MWReachability.h"
#import "MWCommonService.h"
#import "MWFacade.h"
#import "MWTrackingDefine.h"
#import "MWSQLiteManager.h"
#import "MWStrategyConfig.h"
#import "MWAPI.h"
#import "MWPostServiceKey.h"

#define MAX_COUNT           5000    //设置发送tracking数据requestlist的阀值

@interface MW_ConnectionSession()<MWRequestOperationDelegate>
{
    NSUInteger _sendSize;
}

@property (nonatomic,strong) NSMutableArray *eventList;
@property (nonatomic,strong) NSOperationQueue *sendQueue;
@property (nonatomic,strong) NSMutableArray<NSDictionary *> *requestList; // 元素包含：device_info、actions、mw-token这三个key
@property (nonatomic,strong) MWSendConfig *sendConfig;

@end

@implementation MW_ConnectionSession

- (instancetype)initWithType:(MW_ConnectionSessionType)type
{
	if (self = [super init])
	{
        self.type = type;
        self.eventList = [[NSMutableArray alloc] init];
        self.requestList = [[NSMutableArray alloc] init];
        self.sendQueue = [[NSOperationQueue alloc]init];
        [self.sendQueue setMaxConcurrentOperationCount: 1];
        MWStrategyConfig *mwConfig = [MWStrategyConfig sharedInstance];
        self.sendConfig = mwConfig.sendConfig;
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
            @synchronized(self)
            {
                // 将内存中的事件数组 -> 一个发送事件request
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
                
                // 将数据保存下来
                if([MWReachability getNetworkStatus] == NotReachable || _willTerminate)
                {
                    [MWLog log:@"###no network" ];
                    
                    if ([self requestCount] > 0)
                    {
                        [self queuePersistent];
                        [MWLog log:@"### 存储持久化的网络请求"];
                    }
                    
                    // 账号变更了 需要将数据删除
                    if ([[MWFacade sharedInstance] isLoginout]) {
                        [[MWFacade sharedInstance] removeConfig];
                    }
                    
                    return;
                }
                
                // 根据userID拼接本地的数据将数据上传
                NSString *userID = [[MWCommonService sharedInstance] getuserOpenid];
                NSArray<NSDictionary *> *localList = [[MWSQLiteManager share] queryRequestDicsWithUserId:userID];
                if ([MWCommonUtil isNotBlank:localList])
                {
                    [self.requestList addObjectsFromArray:localList];
                    [[MWSQLiteManager share] deleteWithUserId:userID];// 删除数据库数据
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
            
            if ([self requestCount] == 0) {
                // 账号变更了 需要将数据删除
                if ([[MWFacade sharedInstance] isLoginout]) {
                    [[MWFacade sharedInstance] removeConfig];
                }
            }
            
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

// 将事件数组法打包成一个字典
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
        [self.sendQueue addOperation:operation];
    } @catch (NSException *exception) {
    } @finally {
    }
}

- (void)recordEventDic:(NSDictionary *)event
{
    @try {
        @synchronized (self) {
            // 根据配置文件来发送
            if ([MWCommonUtil isNotBlank:event])
            {
                [self.eventList addObject: event];
                _sendSize = _sendConfig.batchSize;
                
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

//-(void )writeArray:(NSMutableArray *)array ToArchive:(NSString *)path
//{
//    @try {
//        @synchronized(self)
//        {
//            NSMutableArray *list = [array mutableCopy];
//            [array removeAllObjects];
//            if (list.count > MAX_COUNT)
//            {
//                [list removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(MAX_COUNT, array.count-MAX_COUNT)]];
//            }
//            [MWNSKeyedArchiverUtils archiveObject:list toPath:path];
//        }
//
//    } @catch (NSException *exception) {
////        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"writeArray:ToArchive:"];
//    } @finally {
//
//    }
//}

-(NSArray *)getArrayFromArchive:(NSString *)path
{
    NSArray *arr =  [MWNSKeyedArchiverUtils unarchiveObjectWithPath:path];
    return arr;
}

- (void) queuePersistent
{
    //TODO*** -[NSFileManager fileSystemRepresentationWithPath:]: unable to allocate memory for length (1072) ( queuePersistent)
    @try {
        [MWLog log:@"##queuePersistent"];
        @synchronized(self)
        {
            @autoreleasepool {
                [self.requestList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull insertDic, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *userID = insertDic[MW_POST_KEY_EVENT_MW_USERID];
                    [[MWSQLiteManager share] insertWithRequestDic:insertDic byUserId:userID];
                }];
            }
            [self.requestList removeAllObjects];
        }
        
    } @catch (NSException *exception) {
    } @finally {
    }
}

- (void) queuePersistentWithRequestDic:(NSDictionary *)dic userID:(NSString *)userID
{
    //TODO*** -[NSFileManager fileSystemRepresentationWithPath:]: unable to allocate memory for length (1072) ( queuePersistent)
    @try {
        
        @synchronized (self) {
            [[MWSQLiteManager share] insertWithRequestDic:dic byUserId:userID];
        }
        
    } @catch (NSException *exception) {
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
        // 账号切换了存在本地，没有切换账号就放在发送队列中
        
        // 如果当前的userid不一样了，就存放在本地
        
        NSString *currentUserid = [[MWCommonService sharedInstance] getuserOpenid];
        NSString *paramUserid = paramDic[MW_POST_KEY_EVENT_MW_USERID];
        
        if ([currentUserid isEqualToString:paramUserid]) {
            [self.requestList addObject:paramDic];
        } else {
            [self queuePersistentWithRequestDic:paramDic userID:paramUserid];
        }
    }
}



- (void)dealloc
{
    [MWLog log:@"##connectionSession dealloc"];
    [self queuePersistent];
}

@end
