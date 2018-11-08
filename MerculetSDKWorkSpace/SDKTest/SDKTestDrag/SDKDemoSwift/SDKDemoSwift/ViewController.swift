//
//  ViewController.swift
//  SDKDemoSwift
//
//  Created by 王大吉 on 31/7/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

import UIKit
import Toast
import CommonCrypto

import MagicWindowUAVSDK
//import MagicWindowUAVSDKBitcode
//import MerculetSDK
//import MerculetSDKBitcode


let _account_key = "a546179a8c644ad99ece4a49f588eb76"
let _app_key = "afce917165954b7e89b6ba654f772c0f"
let _account_secret = "b615fbd8979e4b28b5684074db431662"

class ViewController: UIViewController {
    
    @IBOutlet weak var realBtn: UIButton!
    @IBOutlet weak var closureCountL: UILabel!
    var arrString = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func clearAction() {
        closureCountL.text = "0"
        arrString = [String]()
    }
    
    @IBAction func pushSuccess() {
        
        let tableVC = TableViewController()
        self.navigationController!.pushViewController(tableVC, animated: true)
        tableVC.arrString = arrString
        tableVC.tableView?.reloadData()
        
    }
    
    
    @IBAction func realtime(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected;
        
        //        if (sender.isSelected) {
        //            MWAPI.setSendMode(MWSendConfigTypeRealTime)
        //        } else {
        //            MWAPI.setSendMode(MWSendConfigTypeNormal)
        //        }
    }
    
    @IBAction func zhoutao() {
        self.requestToken(account_key: _account_key, app_key: _app_key, nonce: getRandomNum(), timestamp: getTimestamp(), user_open_id: "zhoutao", account_secret: _account_secret)
    }
    
    @IBAction func wangwei() {
        self.requestToken(account_key: _account_key, app_key: _app_key, nonce: getRandomNum(), timestamp: getTimestamp(), user_open_id: "wangwei", account_secret: _account_secret)
    }
    
    func getRandomNum() -> String {
        return "\(arc4random_uniform(1000000))"
    }
    
    func getTimestamp() -> String {
        return "\(Int64(Date().timeIntervalSince1970 * 1000))"
    }
    
    @IBAction func wangweiInval() {
        MWAPI.setToken("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiY2VhYzE4MjFhYmI0MDkxODBmMGRlNzBjODVjNWEyYyIsImlhdCI6MTUyODI4MzUzNywiZXhwIjoxNTI4NDU2MzM3LCJhcHAiOiJmMjk1YzI3NzJlMTQ0NDQxODljNjc4ZWI5OTViNDUzZCIsImV4dGVybmFsX3VzZXJfaWQiOiJ3YW5nd2VpIn0.eYX-bKeXS6blTzZmvc3GmQDEq5Bh-waxdPfb97923w", userID: "wangwei")
    }
    
    @IBAction func cancel() {
        MWAPI.cancelUserOpenId()
    }
    
    
    
    
    @IBAction func click1(_ sender: UIButton) {
        
        
        var customAction = ""
        var attributes = [String : Any]()
        switch (sender.tag) {
        case 1:// 分享
            customAction = "s_share";
            attributes = [
                "sp_content_type": "s_share1",
                "sp_content_id"  : "s_share_content1",
                "31231"          : "31231"
            ]
        case 2:// 充值
            customAction = "s_recharge";
            attributes = [
                "sp_content_type": "s_recharge1",
                "sp_amount"  : "sp_recharge_amount1",
            ]
            
        case 3:// 评价
            customAction = "s_comment";
            attributes = [
                "sp_content_type": "s_comment1",
                "sp_content_id"  : "s_comment_content1",
            ]
            
        case 4:// 转发
            customAction = "s_forward";
            attributes = [
                "sp_content_type": "s_forward1",
                "sp_content_id"  : "s_forward_content1",
            ]
            
        case 5:// 打赏
            customAction = "s_reward";
            attributes = [
                "sp_amount": 11000.63333,
                "sp_content_type": "s_reward1",
                "sp_content_id"  : "s_reward_content1",
                "st_test": "真有钱"
            ]
            
        case 6:// 关注
            customAction = "s_follow";
            attributes = [
                "sp_content_type": "s_follow1",
                "sp_content_id"  : "s_follow_content1",
            ]
            
        case 7:// 收藏
            customAction = "s_collection";
            attributes = [
                "sp_content_type": "s_collection1",
                "sp_content_id"  : "s_collection_content1",
            ]
        case 8:// 点赞
            customAction = "s_like";
            attributes = [
                "sp_content_type": "s_like1",
                "sp_content_id"  : "s_like_content1",
            ]
        case 9:// 评论
            customAction = "s_comment";
            attributes = [
                "sp_content_type": "s_comment1",
                "sp_content_id"  : "s_comment_content1",
            ]
            
        case 10:// 播放
            customAction = "s_playing";
            attributes = [
                "sp_content_type": "s_playing1",
                "sp_content_id"  : "sp_playing_content1",
                "sp_duration": 22233
            ]
        default:
            return
        }
        
        if realBtn.isSelected {
            
            //            MWAPI.setCustomAction(customAction, attributes: attributes, success: {
            //                DispatchQueue.main.sync {
            //                    var count = (Int)(self.closureCountL.text!)!
            //                    count = count + 1
            //                    self.closureCountL.text = "\(count)"
            //                    self.arrString.append("\(attributes)")
            //                }
            //                toastString("\(attributes)")
            //            }) { (resonse) in
            //                DispatchQueue.main.sync {
            //                    var count = (Int)(self.closureCountL.text!)!
            //                    count = count + 1
            //                    self.closureCountL.text = "\(count)"
            //                }
            //                toastErrorString(resonse!.message)
            //            }
            MWAPI.eventRealTime(customAction, attributes: attributes, success: {
                DispatchQueue.main.sync {
                    var count = (Int)(self.closureCountL.text!)!
                    count = count + 1
                    self.closureCountL.text = "\(count)"
                    self.arrString.append("\(attributes)")
                }
                toastString("\(attributes)")
            }) { (resonse) in
                DispatchQueue.main.sync {
                    var count = (Int)(self.closureCountL.text!)!
                    count = count + 1
                    self.closureCountL.text = "\(count)"
                }
                toastErrorString(resonse!.message)
            }
        } else {
            MWAPI.event(customAction, attributes: attributes)
            //            MWAPI.setCustomAction(customAction, attributes: attributes)
        }
        
        
    }
    
    
    /**
     生成签名sign
     
     :param: account_key    注册时发放的account_key.
     :param: app_key        App对应的Key.
     :param: nonce          随机数.
     :param: timestamp      当前毫秒级时间戳(UTC).
     :param: user_open_id   客户端用户id， user_open_id可以理解成：用户的唯一标识.
     :param: account_secret 商户账号私钥.
     
     :returns: 签名sign
     */
    
    func getSign(account_key: String,
                 app_key: String,
                 nonce: String,
                 timestamp: String,
                 user_open_id: String,
                 account_secret: String) -> String {
        
        let splicerString = account_key + app_key + nonce + timestamp + user_open_id + account_secret
        if splicerString.isEmpty {
            return ""
        }
        return sha256(string: splicerString)
        
    }
    
    // sha256
    func sha256(string: String) -> String{
        
        func digest(input : NSData) -> NSData {
            let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
            var hash = [UInt8](repeating: 0, count: digestLength)
            CC_SHA256(input.bytes, UInt32(input.length), &hash)
            return NSData(bytes: hash, length: digestLength)
        }
        
        func hexStringFromData(input: NSData) -> String {
            var bytes = [UInt8](repeating: 0, count: input.length)
            input.getBytes(&bytes, length: input.length)
            
            var hexString = ""
            for byte in bytes {
                hexString += String(format:"%02x", UInt8(byte))
            }
            
            return hexString
        }
        
        if let stringData = string.data(using: .utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    
    /**
     生成用户凭证token
     
     :param: account_key    注册时发放的account_key.
     :param: app_key        App对应的Key.
     :param: nonce          随机数.
     :param: timestamp      当前毫秒级时间戳(UTC).
     :param: user_open_id   客户端用户id， user_open_id可以理解成：用户的唯一标识.
     :param: account_secret 商户账号私钥.
     */
    func requestToken(account_key: String,
                      app_key: String,
                      nonce: String,
                      timestamp: String,
                      user_open_id: String,
                      account_secret: String) {
        
        // 获取签名sign
        let sign = getSign(account_key: account_key, app_key: app_key, nonce: nonce, timestamp: timestamp, user_open_id: user_open_id, account_secret: account_secret)
        
        let params = [
            "account_key": account_key,// 注册时发放的account_key
            "app_key": app_key,// App对应的Key
            "user_open_id": user_open_id, // 商户端用户id
            "nonce": nonce, // 随机数
            "timestamp": timestamp,// 当前毫秒级时间戳(UTC)
            "sign": sign // 签名
            ] as [String : Any]
        
        MWURLRequestManager().post("https://openapi.magicwindow.cn/v1/user/login", parameters: params, success: { (response, responseObject, data) in
            
            guard let responseObject = responseObject as? [String: Any] else {
                return
            }
            
            if let code = responseObject["code"] as? Int {
                
                if code == 0 {
                    MWAPI.setToken(responseObject["data"] as? String, userID: user_open_id)
                } else {
                    print("mw_error: ",responseObject["message"] ?? "")
                }
            }
            
            
        }) { (response, error) in
            // 网络请求失败
            print("mw_error: token请求失败")
        }
    }
    
}


func toastString(_ text: String) {
    DispatchQueue.main.async {
        UIApplication.shared.keyWindow?.makeToast(text)
        //        try! UIApplication.shared.keyWindow?.toastViewForMessage(text, title: "success", image: nil, style: .init())
    }
    
}

func toastErrorString(_ text: String) {
    DispatchQueue.main.async {
        UIApplication.shared.keyWindow?.makeToast(text)
        //        try! UIApplication.shared.keyWindow?.toastViewForMessage(text, title: "error", image: nil, style: .init())
    }
    
}
