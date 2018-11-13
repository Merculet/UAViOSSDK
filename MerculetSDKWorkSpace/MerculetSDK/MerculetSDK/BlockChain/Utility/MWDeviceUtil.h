//
//  MWCommonDevice.h
//
//
//  Created by 刘家飞 on 15/1/10.
//  Copyright (c) 2015年 All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MWPostServiceKey.h"

@interface MWDeviceUtil : NSObject

@property (nonatomic, strong) NSString *deviceId;       //d
@property (nonatomic, strong) NSString *fingerPrint;    //fp
@property (nonatomic, assign) NSUInteger os;            //os
@property (nonatomic, strong) NSString *osVersion;      //osv
@property (nonatomic, strong) NSString *model;          //m
@property (nonatomic, strong) NSString *screenResolution;//sr
@property (nonatomic, assign) NSUInteger carrier;       //c
@property (nonatomic, strong) NSString *tags;           //ts
@property (nonatomic, assign) NSUInteger network;       //nw

+ (instancetype)share;
//- (NSString *)getIDFA;
- (NSDictionary *)getDevice;
- (NSDictionary *)getAllDevice;
- (NSNumber *)getCarrier;
- (NSUInteger)getNetwork;

@end
