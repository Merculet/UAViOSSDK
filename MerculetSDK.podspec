Pod::Spec.new do |s|

s.name         = "MerculetSDK"
s.version      = "1.0.1"
s.summary      = "MerculetSDK for Cocoapods convenience."
s.homepage     = "http://open.mbc.magicwindow.cn/"
s.license      = "MIT"
s.author       = { "MagicWindow" => "support@magicwindow.cn" }
s.source       = { :git => "https://github.com/Merculet/UAViOSSDK.git", :tag => "#{s.version}" }
s.platform     = :ios, "7.0"
s.requires_arc = true
s.ios.vendored_frameworks = 'China/MerculetSDK.framework'
s.frameworks = "AdSupport","CoreTelephony","CoreGraphics","CoreFoundation","SystemConfiguration","CoreLocation","WebKit","ImageIO"
s.library   = "libc++.tbd"
end
