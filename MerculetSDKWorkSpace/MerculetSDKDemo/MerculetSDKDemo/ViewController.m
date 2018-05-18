//
//  ViewController.m
//  MWBlockChainSampleApp
//
//  Created by 王伟 on 2018/3/7.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import "ViewController.h"
#import "MWAPI.h"
//#import "MWEncryption.h"

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
    [MWAPI setToken:@"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI4NTQ5MDU4MmVkZTg0MTdiODNiZTdiOTc5NTI0NGNiMyIsImlhdCI6MTUyNTk1NDYzMCwiZXhwIjoxNTI2MTI3NDMwLCJhcHAiOiIwYmI5YjlkNDA3MmQ0N2JhOGViOGFmN2M4YzQ3NmRkMyIsImV4dGVybmFsX3VzZXJfaWQiOiJ6aG91dGFvMSJ9.EGogLjHPkIvKrIUdl8iOVbsP4xtN7cc0bGmtdOOhVEU"];
}

- (IBAction)cancel:(id)sender {
    [MWAPI cancelUserOpenId];
}

// 切换账号的时候，（1）将上一次用户的数据上传（2）重新请求新的额token
- (IBAction)change:(id)sender {
    
    [self.view endEditing:YES];
    NSString *userId = self.userOpenT.text;// 必填
    NSString *invitation = self.invitationT.text;// 选填
    
    [MWAPI setUserOpenId:userId invitationCode:invitation];
    
}

/// 点击事件
- (IBAction)click1:(UIButton *)sender {
    
    NSString *customAction;
    NSDictionary *attributes;
    switch (sender.tag) {
        case 1:// 分享
            customAction = @"s_share";
            attributes = @{
                           @"sp_content_type": @"分享",
                           @"sp_content_id"  : @"分享内容ID：10086",
                           @"31231"          : @"31231"
                           };
            break;
        case 2:// 充值
            customAction = @"s_recharge";
            attributes = @{
                           @"sp_content_type": @"充值",
                           @"sp_amount"  : @"充值数量：10086万元",
                           };
            break;
        case 3:// 评价
            customAction = @"s_comment";
            attributes = @{
                           @"sp_content_type": @"评价",
                           @"sp_content_id"  : @"评价内容ID：10086",
                           };
            break;
        case 4:// 转发
            customAction = @"s_forward";
            attributes = @{
                           @"sp_content_type": @"转发",
                           @"sp_content_id"  : @"转发内容ID：10086",
                           };
            break;
        case 5:// 打赏
            customAction = @"s_reward";
            attributes = @{
                           @"sp_amount": @11000.63333,
                           @"sp_content_type": @"打赏",
                           @"sp_content_id"  : @"打赏内容ID：10086",
                           @"st_test": @"真有钱"
                           };
            break;
        case 6:// 关注
            customAction = @"s_follow";
            attributes = @{
                           @"sp_content_type": @"关注",
                           @"sp_content_id"  : @"关注内容ID：10086",
                           };
            break;
        case 7:// 收藏
            customAction = @"s_collection";
            attributes = @{
                           @"sp_content_type": @"收藏",
                           @"sp_content_id"  : @"收藏内容ID：10086",
                           };
            break;
        case 8:// 点赞
            customAction = @"s_like";
            attributes = @{
                           @"sp_content_type": @"点赞",
                           @"sp_content_id"  : @"点赞内容ID：10086",
                           };
            break;
        case 9:// 评论
            customAction = @"s_comment";
            attributes = @{
                           @"sp_content_type": @"评论",
                           @"sp_content_id"  : @"评论内容ID：10086",
                           };
            break;
        case 10:// 播放
            customAction = @"s_playing";
            attributes = @{
                           @"sp_content_type": @"播放",
                           @"sp_content_id"  : @"播放内容ID：10086",
                           @"sp_duration": @22233
                           };
            break;
        default:
            break;
    }
    
    [MWAPI setCustomAction:customAction attributes:attributes];
}



@end
