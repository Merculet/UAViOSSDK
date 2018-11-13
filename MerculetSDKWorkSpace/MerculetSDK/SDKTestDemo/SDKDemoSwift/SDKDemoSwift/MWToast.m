//
//  MWToast.m
//  MerculetSDKDemo
//
//  Created by 王大吉 on 31/7/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

#import "MWToast.h"
#import "UIView+Toast.h"

@implementation MWToast

+ (void)toastString:(NSString *)text {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication.sharedApplication.keyWindow makeToast:text];
    });
}

+ (void)toastFailureString:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication.sharedApplication.keyWindow makeToast:text];
//        [SVProgressHUD showErrorWithStatus:text];
    });
}

@end
