//
//  ViewController.m
//  MWBlockChainSampleApp
//
//  Created by 王伟 on 2018/3/7.
//  Copyright © 2018年 王伟. All rights reserved.
//

#import "ViewController.h"
#import <MerculetSDK/MWAPI.h>

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
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)cancel:(id)sender {
    [MWAPI cancelUserOpenId];
}

// 切换账号的时候，（1）将上一次用户的数据上传（2）重新请求新的额token
- (IBAction)change:(id)sender {
    
    [self.view endEditing:YES];
    NSString *userId = @"XXX";// 必填
    NSString *invitation = @"XXX";// 选填
    
    [MWAPI setUserOpenId:userId invitationCode:invitation];
    
}

// 点击1
- (IBAction)click1:(id)sender {
    [MWAPI setCustomAction:@"eeeee" attributes:@{@"11":@"22"}];
}

// 点击2
- (IBAction)click2:(id)sender {
    [MWAPI setCustomAction:@"aaaaa" attributes:@{@"33":@"44"}];
}

// 点击3
- (IBAction)click3:(id)sender {
    [MWAPI setCustomAction:@"ooooo" attributes:@{@"55":@"66"}];
}


@end
