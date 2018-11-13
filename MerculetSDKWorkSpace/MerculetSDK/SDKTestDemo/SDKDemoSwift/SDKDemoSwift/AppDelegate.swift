//
//  AppDelegate.swift
//  SDKDemoSwift
//
//  Created by 王大吉 on 31/7/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

import UIKit

//import MagicWindowUAVSDK
//import MagicWindowUAVSDKBitcode
//import MerculetSDKBit
import MerculetSDKBitcode

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        MWAPI.registerApp()
        
        MWAPI.showLogEnable(true)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(pushTokenRealTimeExpired(notification:)),
                                               name: NSNotification.Name.MWTokenExpired,
                                               object: nil)
        return true
    }

    
    @objc func pushTokenExpired() {
        print("token 失效")
    }
    
    @objc func pushTokenRealTimeExpired(notification: NSNotification) {
        let userInfo = notification.userInfo;
        toastString("\(userInfo!)")
    }
}

