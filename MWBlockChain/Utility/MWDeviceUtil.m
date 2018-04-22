//
//  MWCommonDevice.m
//
//
//  Created by 刘家飞 on 15/1/10.
//  Copyright (c) 2015年 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWDeviceUtil.h"
#include <sys/sysctl.h>
#include <sys/socket.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import "MWCommonUtil.h"
//#import "MWDictionaryUtils.h"
//#import "MWKeychainItemWrapper.h"
//#import "MWReachability.h"
#import <AdSupport/ASIdentifierManager.h>
#import "MWCommonUtil.h"
#import "MWTrackingDefine.h"

typedef enum
{
    UnknownCarrier = 0,
    ChinaMobile = 1,            //移动
    ChinaUnicom = 2,            //联通
    ChinaTelecom = 3,           //电信
    ChinaTietong = 4            //铁通
}CarrierType;

@implementation MWDeviceUtil

//- (NSDictionary *)getDevice
//{
//    NSDictionary *device = @{MW_POST_KEY_DEVICE_DEVICE_ID:Value_class(self.deviceId),
//                             MW_POST_KEY_DEVICE_FP:Value_class(self.fingerPrint),
//                             MW_POST_KEY_DEVICE_OS:@(self.os),
//                             MW_POST_KEY_DEVICE_OSVS:Value_class(self.osVersion),
//                             MW_POST_KEY_DEVICE_MODEL:Value_class(self.model),
//                             MW_POST_KEY_DEVICE_SCREEN:Value_class(self.screenResolution)};
//       return [MWDictionaryUtils reviewDic:device];
//}
//
//- (NSString *)deviceId
//{
//    @try {
//        NSString *deviceId = [self getUDID];
//        if ([self getIDFA] != nil)
//        {
//            deviceId = [deviceId stringByAppendingString:[NSString stringWithFormat:@",%@",[self getIDFA]]];
//        }
//        return deviceId;
//    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception WithMethodName:@"MWDeviceUtil deviceId"];
//    } @finally {
//
//    }
//}
//
//- (NSString *)fingerPrint
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults stringForKey:@"mw_fp"];
//}
//
+ (NSDictionary *)getIDFA
{
    NSString *idfa = NSClassFromString(@"ASIdentifierManager")?[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]:nil;
    if ([MWCommonUtil isNotBlank:idfa]) {
        return @{MW_POST_KEY_EVENT_device_info_IDFA: idfa};
    }
    return nil;
}
//
//- (NSUInteger)os
//{
//    return 1;
//}
//
//- (NSString *)osVersion
//{
//    return [[UIDevice currentDevice]systemVersion];
//}
//
//- (NSString *)model
//{
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString * platform = [NSString stringWithUTF8String:machine] ;
//    free(machine);
//    return platform;
//}
//
//- (NSString *)screenResolution
//{
//    CGRect rect_screen = [[UIScreen mainScreen]bounds];
//    CGSize size_screen = rect_screen.size;
//    CGFloat scale_screen = [UIScreen mainScreen].scale;
//    CGSize size = CGSizeMake(size_screen.width * scale_screen, size_screen.height * scale_screen);
//    float w = size.width , h = size.height;
//    if (size.width > size.height)
//    {
//        w= size.height;
//        h= size.width;
//    }
//    return [NSString stringWithFormat:@"%1.0fx%1.0f",w,h] ;
//}
//
//- (NSUInteger)carrier
//{
//    return [self carrierType];
//}
//
//- (NSNumber *)getCarrier
//{
//    return @(self.carrier);
//}
//
////运营商
//- (CarrierType)carrierType
//{
//    CarrierType carrierType = UnknownCarrier;
//
//    if ([CTTelephonyNetworkInfo class])
//    {
//        // Setup the Network Info and create a CTCarrier object
//        CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
//        CTCarrier *carrier = [networkInfo subscriberCellularProvider];
//
//        // Get mobile country code
//        NSString *countryCode = [carrier mobileCountryCode];
//        NSInteger mcc = [countryCode intValue];
//
//        if (460 == mcc)    // 460是IMSI中国编号
//        {
//            // Get mobile network code
//            NSString *networkCode = [carrier mobileNetworkCode];
//            NSInteger mnc = [networkCode intValue];
//
//            switch (mnc)
//            {
//                case 0:
//                case 2:
//                case 7:    // 00、02、07均是中国移动
//                {
//                    carrierType = ChinaMobile;
//                }
//                    break;
//                case 1:
//                case 6: // 01、06是中国联通
//                {
//                    carrierType = ChinaUnicom;
//                }
//                    break;
//                case 3:
//                case 5:    // 03、05是中国电信
//                {
//                    carrierType = ChinaTelecom;
//                }
//                    break;
//                case 20:// 20是中国铁通
//                {
//                    carrierType = ChinaTietong;
//                }
//                    break;
//                default:
//                    break;
//            }
//        }
//    }
//    else
//    {
//        carrierType = ChinaUnicom;
//    }
//
//    return carrierType;
//}

//- (NSString *) getUDID {
//    @try {
//        MWKeychainItemWrapper *keychainItem = [[MWKeychainItemWrapper alloc]
//                                               initWithIdentifier:[[NSBundle mainBundle] bundleIdentifier] accessGroup:nil];
//
//        NSString *strUUID = [keychainItem objectForKey:CFBridgingRelease(kSecAttrAccount)];
//
//        if ([strUUID isEqualToString:@""])
//        {
//            CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//            strUUID = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
//            CFRelease(uuidRef);
//            [keychainItem setObject:strUUID forKey:CFBridgingRelease(kSecAttrAccount)];
//        }
//
//        return strUUID == nil ? @"":strUUID;
//    } @catch (NSException *exception) {
//        [MWUncaughtExceptionHandler mwSDKException:exception  WithMethodName:@"MWDeviceUtil  getUDID"];
//    } @finally {
//
//    }
//}

/*
 wifi = 0
 2G = 1
 3G = 2
 4G = 3
 */
//- (NSUInteger)getNetwork
//{
//    NSUInteger net = 0;
//    MWNetworkStatus status = [MWReachability getNetworkStatus];
//    switch (status) {
//        case ReachableViaWiFi:
//        {
//            net = 0;
//            break;
//        }
//        case ReachableVia2G:
//        {
//            net = 1;
//            break;
//        }
//        case ReachableVia3G:
//        {
//            net = 2;
//            break;
//        }
//        case ReachableVia4G:
//        {
//            net = 3;
//            break;
//        }
//
//        default:
//        {
//            net = 5;
//            break;
//        }
//    }
//    self.network = net;
//    return net;
//}

@end
