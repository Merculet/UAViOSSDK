//
//  ViewController.m
//  MWBlockChainSampleApp
//
//  Created by 王伟 on 2018/3/7.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import "ViewController.h"
#import <MerculetSDK/MWAPI.h>
//#import <MagicWindowUAVSDK/MWAPI.h>

@interface ViewController ()


//@property (weak, nonatomic) IBOutlet UITextField *appKeyT;
//@property (weak, nonatomic) IBOutlet UITextField *accountKeyT;
//@property (weak, nonatomic) IBOutlet UITextField *accountSeT;

@property (weak, nonatomic) IBOutlet UITextField *invitationT;

@property (weak, nonatomic) IBOutlet UITextField *userOpenT;
@end

@implementation ViewController
- (IBAction)touch:(id)sender {
    
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 需要开发者自己去请求key，SDK不执行请求token的操作
}

- (IBAction)cancel:(id)sender {
    [MWAPI cancelUserOpenId];
}

// 切换账号的时候，（1）将上一次用户的数据上传（2）重新请求新的额token
- (IBAction)change:(id)sender {
    
//    [self.view endEditing:YES];
//    NSString *userId = self.userOpenT.text;// 必填
//    NSString *invitation = self.invitationT.text;// 选填
//
//    [MWAPI setUserOpenId:userId invitationCode:invitation];
//    [MWAPI setToken:@"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI4NTQ5MDU4MmVkZTg0MTdiODNiZTdiOTc5NTI0NGNiMyIsImlhdCI6MTUyODExMDM1MSwiZXhwIjoxNTI4MjgzMTUxLCJhcHAiOiIwYmI5YjlkNDA3MmQ0N2JhOGViOGFmN2M4YzQ3NmRkMyIsImV4dGVybmFsX3VzZXJfaWQiOiJ6aG91dGFvIiwiYXBwX2xvZ2luX3VybCI6Imh0dHBzOi8vcHJvdGVnZS56eGluc2lnaHQuY29tL2pvaW50LWxvZ2luIn0.Nxxb9-oeM6m1Hx8F2yf_mplTjh06HE78gd4Ib7G1-0I" userID:@"zhoutao"];
    
    [MWAPI setToken:@"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiY2VhYzE4MjFhYmI0MDkxODBmMGRlNzBjODVjNWEyYyIsImlhdCI6MTUyODI4MzQxNSwiZXhwIjoxNTI4NDU2MjE1LCJhcHAiOiJmMjk1YzI3NzJlMTQ0NDQxODljNjc4ZWI5OTViNDUzZCIsImV4dGVybmFsX3VzZXJfaWQiOiJ6aG91dGFvIn0.Jn8MMiRWQd_UfqXT6YFHqTZyYuYvFpBZMlfz6atB09s" userID:@"zhoutao"];
}

- (IBAction)change1:(id)sender {
//    [MWAPI setToken:@"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI4NTQ5MDU4MmVkZTg0MTdiODNiZTdiOTc5NTI0NGNiMyIsImlhdCI6MTUyODExMDM5NywiZXhwIjoxNTI4MjgzMTk3LCJhcHAiOiIwYmI5YjlkNDA3MmQ0N2JhOGViOGFmN2M4YzQ3NmRkMyIsImV4dGVybmFsX3VzZXJfaWQiOiJ3YW5nd2VpIiwiYXBwX2xvZ2luX3VybCI6Imh0dHBzOi8vcHJvdGVnZS56eGluc2lnaHQuY29tL2pvaW50LWxvZ2luIn0.jgSkfsMzvIBSE744EwoHL7tYjJkkmwiSqaOdTBEEPHk" userID: @"wangwei"];
    
    [MWAPI setToken:@"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiY2VhYzE4MjFhYmI0MDkxODBmMGRlNzBjODVjNWEyYyIsImlhdCI6MTUyODI4MzUzNywiZXhwIjoxNTI4NDU2MzM3LCJhcHAiOiJmMjk1YzI3NzJlMTQ0NDQxODljNjc4ZWI5OTViNDUzZCIsImV4dGVybmFsX3VzZXJfaWQiOiJ3YW5nd2VpIn0.eYX-bKeXS6blTzZmvc3GmQDEq5Bh-waxdPfb97923w0" userID:@"wangwei"];
}

- (IBAction)change2:(id)sender {
//    [MWAPI setToken:@"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI4NTQ5MDU4MmVkZTg0MTdiODNiZTdiOTc5NTI0NGNiMyIsImlhdCI6MTUyODExMDM5NywiZXhwIjoxNTI4MjgzMTk3LCJhcHAiOiIwYmI5YjlkNDA3MmQ0N2JhOGViOGFmN2M4YzQ3NmRkMyIsImV4dGVybmFsX3VzZXJfaWQiOiJ3YW5nd2VpIiwiYXBwX2xvZ2luX3VybCI6Imh0dHBzOi8vcHJvdGVnZS56eGluc2lnaHQuY29tL2pvaW50LWxvZ2luIn0.jgSkfsMzvIBSE744EwoHL7tYjJkkmwiSqaOdTBEEPHk1" userID: @"wangwei"];
    
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



@end
