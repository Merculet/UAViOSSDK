//
//  MWSQLiteManager.h
//  MWSQLiteManager
//
//  Created by 王大吉 on 5/6/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface MWSQLiteManager : NSObject

+ (MWSQLiteManager *)share;

//  打开数据库
- (sqlite3 *)openDB;

//  关闭数据库
- (void)closeDB;

//  创建表
- (void)createTable;



//  增加数据
- (void)insertWithRequestDic:(nonnull NSDictionary *)requestDic byUserId:(nonnull NSString *)userId;

//  更改数据
- (void)updateRequestDic:(nonnull NSDictionary *)requestDic byUserId:(nonnull NSString *)UserId;

//  删除数据
- (void)deleteWithUserId:(nonnull NSString *)userId;

//  根据userId查询对应的全部events
- (nullable NSArray *)queryRequestDicsWithUserId:(NSString *)userId;

//  查询全部RequestDics
- (NSArray *)queryAllRequestDics;

//  删除所有的RequestDics
- (void)deleteAllRequestDics;

@end
