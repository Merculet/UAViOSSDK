
# MerculetSDK使用文档（iOS）

----

# 快速集成
#### 获取appKey、accountKey、accountSecret
[进入官网](http://merculet.io/)，按照步骤提示注册应用，可获得appKey、accountKey和accountSecret。
#### 导入SDK
- 下载SDK并集成

拖动文件夹到工程中，拖到工程中后，弹出以下对话框，勾选“Copy items into destination group's folder(if needed)”，并点击“Finish”按钮，如图：

![image.png](https://github.com/Merculet/UAViOSSDK/blob/master/files2.png)

- 添加依赖库
如果使用了Cocoapods集成的SDK，可以忽略此步骤
AdSupport.framework

SystemConfiguration.framework

CoreTelephony.framework

#### 初始化SDK
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
//初始化SDK，必写
NSString * appkey = @"fb61da1dc41f4e1f8d978a9e7547edda";
NSString * accountKey = @"4a0fa34013cc4ffba60c240ad7afe453";
NSString * accountSecret = @"5838f70dbe2e4044a3fffd5d709f23c2";
[MWAPI registerApp:appkey accountKey:accountKey accountSecret:accountSecret]; 

return YES;
}
```

# 自定义事件统计
#### 自定义事件统计
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

#### 统计指定行为
eventName、KeyValue参数需要先在后台管理上注册，才能参与正常的数据统计
```objc
[MWAPI setCustomAction:@"eventName" attributes:@{@"key1":@"value1",@"key2":@"value2",…}];
```

# 注意事项
#### 支持ATS
苹果：2017 年1月1日后所有iOS应用必须启用ATS。 SDK已启用ATS。



