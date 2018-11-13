//
//  MWPostServiceKey.h
//  MagicWindowSampleApp
//
//  Created by 刘家飞 on 14/10/29.
//  Copyright (c) 2014年 MagicWindow. All rights reserved.
//

#ifndef MagicWindowSampleApp_MWPostServiceKey_h
#define MagicWindowSampleApp_MWPostServiceKey_h

// 参数
#define MW_POST_KEY_EVENT_APP_KEY                      @"app_key"          // APP key
#define MW_POST_KEY_EVENT_ACTIONS                      @"actions"           // 行为类型(注册，充值，兑换等)
#define MW_POST_KEY_EVENT_EXTERNAL_USER_ID             @"external_user_id" // 用户在商户端id
#define MW_POST_KEY_EVENT_DEVICE_INFO                  @"device_info"      // idfa, imei等
#define MW_POST_KEY_EVENT_MW_TOKEN                     @"mw-token"      // mw-token
#define MW_POST_KEY_EVENT_MW_USERID                    @"mw-userid"      // mw-userid
#define MW_POST_KEY_EVENT_MW_SIGN                      @"mw-sign"      // mw-token
#define MW_POST_KEY_EVENT_MW_INFO                      @"info"      // info

// token key值
#define MW_POST_KEY_USER_OPEN_ID                       @"user_open_id"          // 用户open_id
#define MW_POST_KEY_ACCOUNT_KEY                        @"account_key"           // 注册时发放的account_key
#define MW_POST_KEY_ACCOUNT_SECRET                     @"account_secret"        // 注册时发放的secret
#define MW_POST_KEY_APP_KEY                            @"app_key"               // App对应的Key
#define MW_POST_KEY_TIMESTAMP                          @"timestamp"             // 当前毫秒级时间戳
#define MW_POST_KEY_NONCE                              @"nonce"                 // 随机数
#define MW_POST_KEY_SIGN                               @"sign"                  // 见说明
#define MW_POST_KEY_INVITATION_CODE                    @"invitation_code"       // 用来关联邀请者

#define MW_POST_KEY_PACKAGE_NAME                @"pn"
#define MW_POST_KEY_DEVICE_TYPE                 @"t"        //0:phone ,1:pad
//#define MW_POST_KEY_APP_KEY                     @"ak"
#define MW_POST_KEY_APP_VERSION                 @"av"
#define MW_POST_KEY_SDK_VERSION                 @"sv"
#define MW_POST_KEY_DEVICE                      @"d"
#define MW_POST_KEY_EVENTS                      @"es"
#define MW_POST_KEY_TAGS                        @"ts"
#define MW_POST_KEY_AD_KEY                      @"k"
#define MW_POST_KEY_APP_CHANNEL                 @"ck"
#define MW_POST_KEY_SESSION                     @"sid"
#define MW_POST_KEY_USER_PROFILE                @"uid"
#define MW_POST_KEY_REGION                      @"re"       //区域
//#define MW_POST_KEY_RAND                        @"r"

#define MW_POST_KEY_EVENT_ACTION                @"a"
#define MW_POST_KEY_EVENT_ACTION_KEY            @"ak"
#define MW_POST_KEY_EVENT_START_TIME            @"st"
#define MW_POST_KEY_EVENT_END_TIME              @"et"
#define MW_POST_KEY_EVENT_NETWORK               @"nw"
#define MW_POST_KEY_EVENT_PAGE_PATH             @"p"
#define MW_POST_KEY_EVENT_PAGE_TITLE            @"t"
#define MW_POST_KEY_EVENT_PREVIOUS_PAGE         @"pp"
#define MW_POST_KEY_EVENT_SOCIAL_NETWORK        @"sn"
#define MW_POST_KEY_EVENT_SOCIAL_ACTION         @"sa"
#define MW_POST_KEY_EVENT_LABEL                 @"l"
#define MW_POST_KEY_EVENT_PARAMETER             @"ps"
#define MW_POST_KEY_EVENT_DYNP                  @"dynp"

// 设备信息参数
#define MW_POST_KEY_EVENT_device_INFO_IDFA      @"idfa"     // idfa
#define MW_POST_KEY_EVENT_device_INFO_OS        @"os"       // os
#define MW_POST_KEY_EVENT_device_INFO_OS_VALUE  @"1"        // os value

#define MW_POST_KEY_DEVICE_OS                   @"os"       //ios :1
#define MW_POST_KEY_DEVICE_OSVS                 @"osv"
#define MW_POST_KEY_DEVICE_MODEL                @"m"
#define MW_POST_KEY_DEVICE_DEVICE_ID            @"d"
#define MW_POST_KEY_DEVICE_FP                   @"fp"
#define MW_POST_KEY_DEVICE_CARRIER              @"c"
#define MW_POST_KEY_DEVICE_SCREEN               @"sr"
#define MW_POST_KEY_DEVICE_FIRST_TIME           @"fa"
#define MW_POST_KEY_DEVICE_FIRST_LAUNCH         @"n"    
#define MW_POST_KEY_MLINK_NEED_DEFER            @"ddl"      //0:不需要，1:需要

#define MW_POST_KEY_LBS_LATITUDE                @"lat"
#define MW_POST_KEY_LBS_LONGITUDE               @"lng"

#define MW_POST_KEY_USER_ID                     @"profileId"//@"id"
#define MW_POST_KEY_USER_PHONE                  @"phone"//@"tel"
#define MW_POST_KEY_USER_EMAIL                  @"email"//@"em"
#define MW_POST_KEY_USER_NAME                   @"displayName"//@"dn"
#define MW_POST_KEY_USER_GENDER                 @"gender"//@"g"
#define MW_POST_KEY_USER_BIRTHYDAY              @"birthday"//@"b"
#define MW_POST_KEY_USER_COUNTRY                @"country"//@"c"
#define MW_POST_KEY_USER_PROVINCE               @"province"//@"p"
#define MW_POST_KEY_USER_CITY                   @"city"//@"ct"
#define MW_POST_KEY_USER_REMARK                 @"remark"//@"mk"
#define MW_POST_KEY_USER_RANK                   @"userRank"

#define MW_POST_KEY_MLINK_DT                    @"dt"
#define MW_POST_KEY_ACTIVITY_KEY                @"ack"
#define MW_POST_KEY_MLINK_URI                   @"dp"

#define MW_POST_KEY_DMW                         @"dmw"

#endif
