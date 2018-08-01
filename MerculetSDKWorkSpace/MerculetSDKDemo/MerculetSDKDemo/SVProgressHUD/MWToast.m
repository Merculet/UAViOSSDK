//
//  MWToast.m
//  MerculetSDKDemo
//
//  Created by 王大吉 on 31/7/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import "MWToast.h"
#import "SVProgressHUD.h"

@implementation MWToast

+ (void)toastString:(NSString *)text {
    [SVProgressHUD showSuccessWithStatus:text];
}

@end
