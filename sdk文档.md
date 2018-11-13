# iOS集成文档


## 一、集成准备
### 1.1 准备工作

#### 1.1.1 注册GAAS账号
[注册GAAS账号](http://open.merculet.cn/login)，并完成企业认证。

#### 1.1.2 获取Key
进入GAAS，"创建通证" -> "添加应用" -> "技术对接"，获取以下三个基本参数：AppKey、AccountKey、AccountSecret。
![获取Key.png](https://img.merculet.cn/mw_doc_6.jpg)



### 1.2 导入SDK

以下两种方法，任选一种即可。

#### 方法1 使用 CocoaPods 安装 SDK

```c
pod 'MerculetCNUAV'
```

如果项目要求支持bitcode，可导入**bitcode版本**

```c
pod 'MerculetCNUAVBitcode'
```

#### 方法2 手动导入

**（1） 添加依赖的库**
 
 
 AdSupport.framework


SystemConfiguration.framework


CoreTelephony.framework


libc++.tbd

WebKit.framework

**（2） 引入SDK资源**

[前往SDK下载地址](https://mb-helpcenter.merculet.cn/doc/download)，将下载的framework和bundle文件拖动到工程中，拖到工程中后，弹出以下对话框，勾选“Copy items into destination group's folder(if needed)”，并点击“Finish”按钮，如图：

![image.png](https://sdk.mlinks.cc/merculet_doc_image_001.png)



## 二 基本功能集成

### 2.1 初始化SDK

#### 2.1.1 头文件引用

在AppDelegate中，添加头文件

**Objective-C**

```objc
#import <MerculetCNUAV/MWAPI.h>
```

**Swift**

```swift
import MerculetCNUAV
```


#### 2.1.2 调用registerApp方法来初始化SDK
在application:didFinishLaunchingWithOptions:方法中调用registerApp方法来初始化SDK，代码如下：

**Objective-C**

```objc
#import "AppDelegate.h"
#import <MerculetCNUAV/MWApi.h>

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
// 初始化SDK
[MWAPI registerApp]; 

return YES;
}
```

**Swift**

```swift
import MerculetCNUAV
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        // 初始化SDK
        MWAPI.registerApp()
        return true
    }
}

```


#### 2.1.3 获取用户凭证token

> 基于安全性考虑，SDK不提供用户凭证token的获取，开发者需要自己[获取凭证token](https://mb-helpcenter.merculet.cn/doc/api)。请求token的操作建议放在服务端进行，再将token传到客户端。


**（1）生成签名sign**


**把除了sign以外所有参数名按照字母序排列, 将它们的值按照此顺序拼接, 空值拼空字符串。**

根据```account_key```、```app_key```、```nonce```（随机数）、```timestamp```（当前时间戳）、```user_open_id```（用户唯一标识）、```account_secret```等六个参数，生成签名sign。


可以使用[签名(sign)验证工具](http://open.merculet.cn/main/docking/sdk)，校验你生成签名sign是否正确，如图所示。
![生成签名sign.pn](https://mvpimg.mlinks.cc/merculetSDK/mw_doc_4.jpg)



如需在客户端生成token，客户端获取sign的示例代码如下：

> 生成签名sign和请求token的时间戳nonce、随机数timestamp需保持一致

**Objective-C**


```Objc
// sha256
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
```

```Objc
/**
 *  生成签名sign
 *  @param account_key      注册时发放的account_key
 *  @param app_key          App对应的Key
 *  @param nonce            随机数
 *  @param timestamp        当前毫秒级时间戳(UTC)
 *  @param user_open_id     客户端用户id， user_open_id可以理解成：用户的唯一标识
 *  @param account_secret   商户账号私钥
 */
- (NSString *)getSignWithAccount_key:(NSString *)account_key
                             app_key:(NSString *)app_key
                               nonce:(NSString *)nonce
                           timestamp:(NSString *)timestamp
                        user_open_id:(NSString *)user_open_id
                      account_secret: (NSString *)account_secret {
    
    NSMutableString *splicerString = [NSMutableString string];
    [splicerString appendString:account_key];
    [splicerString appendString:app_key];
    [splicerString appendString:nonce];
    [splicerString appendString:timestamp];
    [splicerString appendString:user_open_id];
    [splicerString appendString:account_secret];
    
    if (splicerString != nil && splicerString.length != 0) {
        NSString *generateString = [self sha256WithString:splicerString];
        return generateString;
    } else {
        return @"";
    }
}


/**
 *  SHA256
 */
- (NSString*)sha256WithString:(NSString *)splicerString
{
    const char *cstr = [splicerString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:splicerString.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
```


**Swift**

```swift
import CommonCrypto
```

```swift
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
    
    /// sha256
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
    
```

**（2）网络请求获取用户凭证token**

如需在客户端生成token，客户端获取token的示例代码如下：

**Objective-C**


```objc

/**
 *  生成用户凭证token
 *  @param account_key      注册时发放的account_key
 *  @param app_key          App对应的Key
 *  @param account_secret   商户账号私钥
 *  @param user_open_id     客户端用户id， user_open_id可以理解成：用户的唯一标识
 *  @param nonce            随机数
 *  @param timestamp        当前毫秒级时间戳(UTC)
 */
- (void)requestTokenWithAccount_key:(NSString *)account_key
                        app_key:(NSString *)app_key
                 account_secret:(NSString *)account_secret
                   user_open_id:(NSString *)user_open_id
                          nonce:(NSString *)nonce
                      timestamp:(NSString *)timestamp {
    
    // 获取签名sign
    NSString *sign = [self getSignWithAccount_key:account_key app_key:app_key nonce:nonce timestamp:timestamp user_open_id:user_open_id account_secret:account_secret];
    
    if (sign.length == 0) { return; }
    
    NSDictionary *dic = @{
        @"account_key": account_key,
        @"app_key": app_key,
        @"user_open_id": user_open_id,
        @"nonce": nonce,
        @"timestamp": timestamp,
        @"sign": sign
        };
    
    [[MWURLRequestManager alloc] POST:@"https://openapi.merculet.cn/v1/user/login" parameters:dic success:^(NSURLResponse *response, id responseObject, NSData *data) {
        
        NSLog(@"%d", [responseObject[@"code"] intValue]);
        
        if ([responseObject[@"code"] intValue] == 0) {
            [MWAPI setToken:responseObject[@"data"]
                     userID:user_open_id];
        } else {
            NSLog(@"mw_error: %@",responseObject[@"message"]);
        }
        
    } failure:^(NSURLResponse *response, NSError *error) {
        NSLog(@"mw_error: token请求失败");
    }];
}
```


**Swift**

```swift
    /**
        请求用户凭证token
     
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
            "account_key": account_key,
            "app_key": app_key,
            "user_open_id": user_open_id, 
            "nonce": nonce, 
            "timestamp": timestamp,
            "sign": sign 
            ] as [String : Any]
        
        MWURLRequestManager().post("https://openapi.merculet.cn/v1/user/login", parameters: params, success: { (response, responseObject, data) in
            
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
```

#### 2.1.4 开启追踪用户行为

> 此操作建议放在客户端用户登录成功后使用。

在请求到token后，需要开启对用户行为的追踪，需要调用

**Objective-C**

```objc
[MWAPI setToken:@"请求到的token" userID:@"用户唯一标识"];
```

**Swift**

```swift
MWAPI.setToken("请求到的token", userID: "用户唯一标识")
```

#### 2.1.5 取消追踪用户行为

在不需要追踪用户行为或者切换用户时，需要调用

**Objective-C**

```objc
[MWAPI cancelUserOpenId];
```

**Swift**

```swift
MWAPI.cancelUserOpenId()
```

#### 2.1.6 处理用户凭证token过期

当token过期时，会以**通知**的形式告知，NSNotificationName为**MWTokenExpiredNotification**

**Objective-C**

```objc
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xxx) name:MWTokenExpiredNotification object:nil];
```

**Swift**

```swift
NotificationCenter.default.addObserver(self, selector: #selector(xxx), name: NSNotification.Name.MWTokenExpired, object: nil)
```

### 2.2 事件统计

[登录GAAS系统](http://open.merculet.cn/main/docking/event-list)，"入驻管理" -> "应用列表" -> "技术对接" -> "事件管理" -> "添加事件"，添加自定义事件，并配置事件名称、事件Key、事件属性等参数后，再进行事件统计。

![](https://img.merculet.cn/mw_doc_7.jpg)


**统计场景举例**

如需在收集用户的分享事件：事件名称为“分享”，事件Key为”s_share“，事件属性分别为sp_content_type、p_content_id、sp_content_source、sp_content_channel。点击"添加自定义事件" -> "事件管理"，其配置如图所示。

![](https://img.merculet.cn/mw_doc_8.jpg)


在客户端设置事件属性对应的value分别为"shareType"、"share_100"、"share_source_weibo"、"share_source_weixin"。



其代码如下：


**Objective-C**

```objc
[MWAPI event:@"s_share" attributes:@{@"sp_content_type":@"shareType",@"p_content_id":@"share_100",@"sp_content_source":@"share_source_weibo",@"sp_content_source":@"",@"sp_content_channel":@"share_source_weixin"}];
```

**Swift**

```swift
MWAPI.event("s_share", attributes: ["sp_content_type":"shareType", "p_content_id":"share_100","sp_content_source":"share_source_weibo","sp_content_channel":"share_source_weixin"])
```


> SDK事件上传机制：（默认）每满30条行为或每隔1分钟，将事件上传。

如需实时统计用户行为，请用以下代码：


**Objective-C**

```objc
[MWAPI eventRealTime:@"s_share" attributes:@{@"sp_content_type":@"shareType",@"p_content_id":@"share_100",@"sp_content_source":@"share_source_weibo",@"sp_content_source":@"",@"sp_content_channel":@"share_source_weixin"}];
```

**Swift**

```swift
MWAPI.eventRealTime("s_share" , attributes: ["sp_content_type":"shareType", "p_content_id":"share_100","sp_content_source":"share_source_weibo","sp_content_channel":"share_source_weixin"])
```


## 三、 测试与调试
请在程序入口或在application:didFinishLaunchingWithOptions:方法中调用如下代码：

**objective-c**

```objc
[MWAPI showLogEnable:YES];
```

**swift**

```swift
MWAPI.showLogEnable(true)
```

当控制台输出“merculet log success: 已检测到用户凭证token的输入，SDK集成成功，可以上传事件”时，即SDK集成成功。


## 四、 注意事项
### 支持ATS
苹果：2017 年1月1日后所有iOS应用必须启用ATS。SDK已启用ATS。





