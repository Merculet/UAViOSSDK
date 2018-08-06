Pod::Spec.new do |s|
s.name         = "MerculetSDKBitcode"
s.version      = "1.1.0"
s.summary      = "MerculetSDKBitcode for Cocoapods convenience."
s.homepage     = "http://open.mbc.magicwindow.cn/"
s.license      = "MIT"
s.author       = { "Merculet" => "support@merculet.cn" }
s.source       = { :git => "https://github.com/Merculet/UAViOSSDK.git", :tag => s.version }
s.platform     = :ios
s.ios.deployment_target = "7.0"
s.requires_arc = true
s.ios.vendored_frameworks = 'Products/MerculetSDKBitcode.framework'
s.frameworks = "AdSupport","CoreTelephony","CoreFoundation","SystemConfiguration"
s.library   = "c++"
end
