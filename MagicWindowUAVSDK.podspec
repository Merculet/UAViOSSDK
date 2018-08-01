Pod::Spec.new do |s|
s.name         = "MagicWindowUAVSDK"
s.version      = "1.0.32.1"
s.summary      = "MagicWindowUAVSDK for Cocoapods convenience."
s.homepage     = "http://open.mbc.magicwindow.cn/"
s.license      = "MIT"
s.author       = { "MagicWindow" => "support@magicwindow.cn" }
s.source       = { :git => "https://github.com/Merculet/UAViOSSDK.git", :tag => s.version }
s.platform     = :ios
s.ios.deployment_target = "7.0"
s.requires_arc = true
s.ios.vendored_frameworks = 'Products/MagicWindowUAVSDK.framework'
s.frameworks = "AdSupport","CoreTelephony","CoreFoundation","SystemConfiguration"
s.library   = "c++"
end
