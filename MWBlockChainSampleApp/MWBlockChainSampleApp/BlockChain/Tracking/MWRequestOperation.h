//
//  MWRequestOperation.h
//  MWBlockChain
//
//  Created by 王伟 on 2018/3/12.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MWRequestOperation;

@protocol MWRequestOperationDelegate <NSObject>

- (void)requestFail:(MWRequestOperation *)operation withParamDic:(NSDictionary *)paramDic;
- (void)requestSuccess:(MWRequestOperation *)operation withParamDic:(NSDictionary *)paramDic;

@end

@interface MWRequestOperation : NSOperation<NSCoding>

// 定义一个operation事件
- (id)initWithParamDic:(NSDictionary *)paramDic delegate:(id<MWRequestOperationDelegate> ) delegate;
@property (nonatomic,weak) id<MWRequestOperationDelegate> delegate;
//@property (nonatomic)RequestTag tag;

@end
