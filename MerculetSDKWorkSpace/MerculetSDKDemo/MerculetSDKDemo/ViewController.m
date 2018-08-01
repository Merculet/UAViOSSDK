//
//  ViewController.m
//  MWBlockChainSampleApp
//
//  Created by 王伟 on 2018/3/7.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import "ViewController.h"
#import <MerculetSDK/MWAPI.h>
#import <MerculetSDK/MWURLRequestManager.h>
#import "SVProgressHUD.h"

@interface ViewController ()


//@property (weak, nonatomic) IBOutlet UITextField *appKeyT;
//@property (weak, nonatomic) IBOutlet UITextField *accountKeyT;
//@property (weak, nonatomic) IBOutlet UITextField *accountSeT;

@property (weak, nonatomic) IBOutlet UITextField *invitationT;

@property (weak, nonatomic) IBOutlet UITextField *userOpenT;

@property (weak, nonatomic) IBOutlet UIButton *realBtn;

@end

@implementation ViewController
- (IBAction)touch:(id)sender {
    
    [self.view endEditing:YES];
}

// 实时发送
- (IBAction)realtimeAction:(UIButton *)realBtn {
    realBtn.selected = !realBtn.selected;
    
    if (realBtn.selected) {
        [MWAPI setSendMode:MWSendConfigTypeRealTime];
    } else {
        [MWAPI setSendMode:MWSendConfigTypeNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 需要开发者自己去请求key，SDK不执行请求token的操作 
}

- (IBAction)cancel:(id)sender {
    [MWAPI cancelUserOpenId];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [SVProgressHUD dismiss];
}

// 切换账号的时候，（1）将上一次用户的数据上传（2）重新请求新的额token
- (IBAction)change:(id)sender {

    [self getToken:@"zhoutao"];
}

- (IBAction)change1:(id)sender {

    [self getToken:@"wangwei"];
}

- (IBAction)change2:(id)sender {

    [MWAPI setToken:@"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiY2VhYzE4MjFhYmI0MDkxODBmMGRlNzBjODVjNWEyYyIsImlhdCI6MTUyODI4MzUzNywiZXhwIjoxNTI4NDU2MzM3LCJhcHAiOiJmMjk1YzI3NzJlMTQ0NDQxODljNjc4ZWI5OTViNDUzZCIsImV4dGVybmFsX3VzZXJfaWQiOiJ3YW5nd2VpIn0.eYX-bKeXS6blTzZmvc3GmQDEq5Bh-waxdPfb97923w" userID:@"wangwei"];
}

/// 点击事件
- (IBAction)click1:(UIButton *)sender {
    
    NSString *customAction;
    NSDictionary *attributes;
    switch (sender.tag) {
        case 1:// 分享
            customAction = @"s_share";
            attributes = @{
                           @"sp_content_type": @"s_share1",
                           @"sp_content_id"  : @"s_share_content1",
                           @"31231"          : @"31231"
                           };
            break;
        case 2:// 充值
            customAction = @"s_recharge";
            attributes = @{
                           @"sp_content_type": @"s_recharge1",
                           @"sp_amount"  : @"sp_recharge_amount1",
                           };
            break;
        case 3:// 评价
            customAction = @"s_comment";
            attributes = @{
                           @"sp_content_type": @"s_comment1",
                           @"sp_content_id"  : @"s_comment_content1",
                           };
            break;
        case 4:// 转发
            customAction = @"s_forward";
            attributes = @{
                           @"sp_content_type": @"s_forward1",
                           @"sp_content_id"  : @"s_forward_content1",
                           };
            break;
        case 5:// 打赏
            customAction = @"s_reward";
            attributes = @{
                           @"sp_amount": @11000.63333,
                           @"sp_content_type": @"s_reward1",
                           @"sp_content_id"  : @"s_reward_content1",
                           @"st_test": @"真有钱"
                           };
            break;
        case 6:// 关注
            customAction = @"s_follow";
            attributes = @{
                           @"sp_content_type": @"s_follow1",
                           @"sp_content_id"  : @"s_follow_content1",
                           };
            break;
        case 7:// 收藏
            customAction = @"s_collection";
            attributes = @{
                           @"sp_content_type": @"s_collection1",
                           @"sp_content_id"  : @"s_collection_content1",
                           };
            break;
        case 8:// 点赞
            customAction = @"s_like";
            attributes = @{
                           @"sp_content_type": @"s_like1",
                           @"sp_content_id"  : @"s_like_content1",
                           };
            break;
        case 9:// 评论
            customAction = @"s_comment";
            attributes = @{
                           @"sp_content_type": @"s_comment1",
                           @"sp_content_id"  : @"s_comment_content1",
                           };
            break;
        case 10:// 播放
            customAction = @"s_playing";
            attributes = @{
                           @"sp_content_type": @"s_playing1",
                           @"sp_content_id"  : @"sp_playing_content1",
                           @"sp_duration": @22233
                           };
            break;
        default:
            break;
    }
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//    });
    [MWAPI setCustomAction:customAction attributes:attributes];
    
}

- (void)getToken:(NSString *)userName {
    
    NSDictionary *dic = @{
        @"account_key": @"5506d5a3f26943ed916797fb9dd74825",
        @"app_key":@"bf09f57ee8ff422881f267ab06c666c7",
        @"user_open_id":userName,
        @"nonce":@"3823745",
        @"timestamp":@"1520417211138",
        @"sign":@"7fLEjFPhW9AmF5cKYbilYRx52ij3ceCVXKCgUk6UfXMwAWczvTWqlAQTGHIQuG8yL5p3givh8kHMrOoAOpAbM6RNpiQ4erfMLgPtTMIPiXbtBu9LclqygZ2JmPQs9bIY"
        };
    
    [[MWURLRequestManager alloc] POST:@"https://openapi.magicwindow.cn/v1/user/login"
//                              headers:@{@"Content-Type":@"application/json"}
                           parameters:dic
                              success:^(NSURLResponse *response, id responseObject, NSData *data) {
        
        [MWAPI setToken:responseObject[@"data"]
                 userID:userName];
    } failure:^(NSURLResponse *response, NSError *error) {
        
    }];

}



@end
