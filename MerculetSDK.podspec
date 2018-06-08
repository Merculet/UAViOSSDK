Pod::Spec.new do |s|
s.name         = "MerculetSDK"
s.version      = "1.0.0"
s.summary      = "MerculetSDK for Cocoapods convenience."
s.homepage     = "http://open.mbc.magicwindow.cn/"
s.license      = "MIT"
s.author       = { "Merculet" => "support@merculet.cn" }
s.source       = { :git => "https://github.com/Merculet/UAViOSSDK.git", :tag => "v1.0.1" }
s.platform     = :ios
s.ios.deployment_target = "7.0"
s.requires_arc = true
s.ios.vendored_frameworks = 'MerculetSDK.framework'
s.frameworks = "AdSupport","CoreTelephony","CoreFoundation","SystemConfiguration"
s.library   = "c++"
end
