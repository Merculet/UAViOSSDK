Pod::Spec.new do |s|
s.name         = "MerculetCNSDKBitcode"
s.version      = "1.1.4"
s.summary      = "MerculetCNSDKBitcode for Cocoapods convenience."
s.homepage     = "https://open.merculet.cn/"
s.license      = "MIT"
s.author       = { "ios_support" => "ios_support@merculet.io" }
s.source       = { :git => "https://github.com/Merculet/UAViOSSDK.git", :tag => s.version }
s.platform     = :ios
s.ios.deployment_target = "8.0"
s.requires_arc = true
s.ios.vendored_frameworks = 'Products/MerculetCNSDKBitcode.framework'
s.frameworks = "AdSupport","CoreTelephony","CoreFoundation","SystemConfiguration"
s.resource = "Products/MerculetSDK.bundle"
s.library   = "c++"
end
