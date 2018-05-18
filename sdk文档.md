
# iOS集成文档


# 快速集成
## 获取appkey、account_key、account_secret
[进入官网](http://merculet.io/)，按照步骤提示注册应用，可获得appkey、account_key、account_secret。

## 获取Token
基于上述三个数值，接入方需要调用Merculet的签发Token的接口。

## 导入SDK
- 下载SDK并集成

拖动文件夹到工程中，拖到工程中后，弹出以下对话框，勾选“Copy items into destination group's folder(if needed)”，并点击“Finish”按钮，如图：

![image.png](https://github.com/Merculet/UAViOSSDK/blob/master/files2.png)

- 添加依赖库


AdSupport.framework


SystemConfiguration.framework


CoreTelephony.framework


libc++.tbd

## 初始化SDK
在AppDelegate中，添加头文件引用

```objc
#import <MerculetSDK/MWApi.h>
```

在application:didFinishLaunchingWithOptions:方法中调用registerApp方法来初始化SDK，如下代码：

```objc
#import "AppDelegate.h"
#import <MerculetSDK/MWApi.h>
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//初始化SDK
[MWAPI registerApp]; 

return YES;
}
```

初始化完成之后，需要向sdk设置token

```objc
[MWAPI setToken:token];
```

# 自定义事件统计
## 自定义事件统计
- 传入用户的userId（必填项）和邀请码（选填项）
由于SDK是跟踪用户的行为的，所以确保在传入了userId，否则SDK不会收集任何信息

```objc
NSString *userId = @"XXX";// 必填
NSString *invitation = @"XXX";// 选填
[MWAPI setUserOpenId:userId invitationCode:invitation];
```

-  取消对用户的追踪 
不能将userOpenId直接设置成nil或空字符串

```objc
[MWAPI cancelUserOpenId];
```

## 统计指定行为
eventName、KeyValue参数需要先在后台管理上注册，才能参与正常的数据统计

```objc
[MWAPI setCustomAction:@"eventName" attributes:@{@"key1":@"value1",@"key2":@"value2",…}];
```

# 注意事项
## 支持ATS
苹果：2017 年1月1日后所有iOS应用必须启用ATS。SDK已启用ATS。
