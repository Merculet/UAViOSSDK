//
//  MWTrackingDefine.h
//  MWBlockChain
//
//  Created by 王伟 on 2018/3/12.
//  Copyright © 2018年 王伟. All rights reserved.
//

#ifndef MWTrackingDefine_h
#define MWTrackingDefine_h

// json解析
#define MW_POST_JSON_Code                     @"code"          // code
#define MW_POST_JSON_Message                  @"message"           // message

// 参数
#define MW_POST_KEY_EVENT_app_key                      @"app_key"          // APP key
#define MW_POST_KEY_EVENT_actions                      @"actions"           // 行为类型(注册，充值，兑换等)
#define MW_POST_KEY_EVENT_external_user_id             @"external_user_id" // 用户在商户端id
#define MW_POST_KEY_EVENT_device_info                  @"device_info"      // idfa, imei等
#define MW_POST_KEY_EVENT_MW_Token                     @"mw-token"      // mw-token
#define MW_POST_KEY_EVENT_MW_UserID                    @"mw-userid"      // mw-userid
#define MW_POST_KEY_EVENT_MW_Sign                      @"mw-sign"      // mw-token
#define MW_POST_KEY_EVENT_MW_info                       @"info"      // info

// token key值
#define MW_POST_KEY_user_open_id                       @"user_open_id"          // 用户open_id
#define MW_POST_KEY_account_key                        @"account_key"           // 注册时发放的account_key
#define MW_POST_KEY_account_secret                     @"account_secret"        // 注册时发放的secret
#define MW_POST_KEY_app_key                            @"app_key"               // App对应的Key
#define MW_POST_KEY_timestamp                          @"timestamp"             // 当前毫秒级时间戳
#define MW_POST_KEY_nonce                              @"nonce"                 // 随机数
#define MW_POST_KEY_sign                               @"sign"                  // 见说明
#define MW_POST_KEY_invitation_code                    @"invitation_code"       // 用来关联邀请者


// 设备信息参数
#define MW_POST_KEY_EVENT_device_info_IDFA             @"idfa"      // idfa
#define MW_POST_KEY_EVENT_device_info_OS               @"os"           // os

// 发送配置信息
#define SEND_STRATEGY_CHECK_INTERVAL        60
#define SEND_STRATEGY_CHECK_NUM             30

#endif /* MWTrackingDefine_h */
