//
//  ViewController.swift
//  SDKDemoSwift
//
//  Created by 王大吉 on 31/7/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

import UIKit
import CommonCrypto
//import MagicWindowUAVSDK
//import MagicWindowUAVSDKBitcode
//import MerculetSDK
import MerculetSDKBitcode


let _account_key = "d00267cd1e494b3887fb1b324cbab042"
let _app_key = "a1a3b948d8b045c885adaa4048f07a49"
let _account_secret = "f553bf71bec5405f9f5aa51ac8a84801"


class ViewController: UIViewController {
    
    // APP 参数配置
    @IBOutlet weak var appkeyF: UITextField!
    @IBOutlet weak var accountkeyF: UITextField!
    @IBOutlet weak var accountsecretF: UITextField!
    
    // 用户登录
    @IBOutlet weak var useropenidF: UITextField!
    
    // 监控策略
    @IBOutlet weak var realBtn: UIButton!
    
    // 监控参数配置
    @IBOutlet weak var customActionF: UITextField!
    @IBOutlet weak var keyF1: UITextField!
    @IBOutlet weak var valueF1: UITextField!
    @IBOutlet weak var keyF2: UITextField!
    @IBOutlet weak var valueF2: UITextField!
    @IBOutlet weak var keyF3: UITextField!
    @IBOutlet weak var valueF3: UITextField!
    
    // 参考请求结果
    @IBOutlet weak var closureCountL: UILabel!
    var arrString = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appkeyF.text = _app_key
        accountkeyF.text = _account_key
        accountsecretF.text = _account_secret
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap1))
        view.addGestureRecognizer(tap)
    }

    @objc func tap1() {
        view.endEditing(true)
    }
   
}



///MARK: 私有方法
extension ViewController {
    func getRandomNum() -> String {
        return "\(arc4random_uniform(1000000))"
    }
    
    func getTimestamp() -> String {
        return "\(Int64(Date().timeIntervalSince1970 * 1000))"
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
        
        MWURLRequestManager().post("http://score-query-cn.liaoyantech.cn/v1/user/login", parameters: params, success: { (response, responseObject, data) in
            
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

///MARK: APP 参数配置
extension ViewController {
    
}


///MARK: 用户登录
extension ViewController {
    
    func login(user_open_id: String)  {
        guard let text = accountkeyF.text , !text.isEmpty else {
            toastErrorString("请输入accountkey")
            return
        }
        
        guard let text1 = appkeyF.text , !text1.isEmpty else {
            toastErrorString("请输入appkey")
            return
        }
        
        guard let text2 = accountsecretF.text , !text2.isEmpty else {
            toastErrorString("请输入accountsecret")
            return
        }
        
        requestToken(account_key: text,
                     app_key: text1,
                     nonce: getRandomNum(),
                     timestamp: getTimestamp(),
                     user_open_id: user_open_id,
                     account_secret: text2)
    }
    
    @IBAction func zhoutao() {
        login(user_open_id: "zhoutao")
    }
    
    @IBAction func wangwei() {
        login(user_open_id: "wangwei")
    }
    
    //    @IBAction func wangweiInval() {
    //        MWAPI.setToken("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiY2VhYzE4MjFhYmI0MDkxODBmMGRlNzBjODVjNWEyYyIsImlhdCI6MTUyODI4MzUzNywiZXhwIjoxNTI4NDU2MzM3LCJhcHAiOiJmMjk1YzI3NzJlMTQ0NDQxODljNjc4ZWI5OTViNDUzZCIsImV4dGVybmFsX3VzZXJfaWQiOiJ3YW5nd2VpIn0.eYX-bKeXS6blTzZmvc3GmQDEq5Bh-waxdPfb97923w", userID: "wangwei")
    //    }
    
    @IBAction func login() {
        if let text = useropenidF.text, !text.isEmpty {
            login(user_open_id: text)
        } else {
            toastErrorString("请输入用的唯一标识")
        }
    }
    
    @IBAction func cancel() {
        MWAPI.cancelUserOpenId()
    }
    
}


///MARK: 监控策略
extension ViewController {
    @IBAction func realtime(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected;
    }
}


///MARK: 监控参数配置
extension ViewController {
    
    @IBAction func sendEventAttributes() {
        
        var attributes = [String : Any]()
    
        guard let text = customActionF.text, !text.isEmpty else {
            toastErrorString("customAction没有输入")
            return
        }
        
        
        if let keyF1T = keyF1.text, !keyF1T.isEmpty {
            guard let valueF1T = valueF1.text, !valueF1T.isEmpty else {
                toastErrorString("请把参数填写完整")
                return
            }
            attributes[keyF1T] = valueF1T
        }
        
        if let keyF2T = keyF2.text, !keyF2T.isEmpty {
            guard let valueF2T = valueF2.text, !valueF2T.isEmpty else {
                toastErrorString("请把参数填写完整")
                return
            }
            attributes[keyF2T] = valueF2T
        }
        
        if let keyF3T = keyF3.text, !keyF3T.isEmpty {
            guard let valueF3T = valueF3.text, !valueF3T.isEmpty else {
                toastErrorString("请把参数填写完整")
                return
            }
            attributes[keyF3T] = valueF3T
        }
        
        if attributes.isEmpty {
            toastErrorString("请把参数填写完整")
            return
        }
        
        sendEvent(customAction: text, attributes: attributes)
    }
    
    func sendEvent(customAction: String, attributes: [String: Any]) {
        
        if realBtn.isSelected {
            MWAPI.eventRealTime(customAction, attributes: attributes)
        } else {
            MWAPI.event(customAction, attributes: attributes)
        }
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
        
        sendEvent(customAction: customAction, attributes: attributes)
        
    }
}


///MARK: 参考请求结果
extension ViewController {
    
    @IBAction func clearAction() {
        closureCountL.text = "0"
        arrString = [String]()
    }
    
    @IBAction func pushSuccessMessage() {
        
        let tableVC = TableViewController()
        self.navigationController!.pushViewController(tableVC, animated: true)
        tableVC.arrString = arrString
        tableVC.tableView?.reloadData()
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
