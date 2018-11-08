Pod::Spec.new do |s|
s.name         = "MagicWindowUAVSDK"
s.version      = "1.1.4"
s.summary      = "MagicWindowUAVSDK for Cocoapods convenience."
s.homepage     = "http://open.mbc.magicwindow.cn/"
s.license      = "MIT"
s.author       = { "MagicWindow" => "support@magicwindow.cn" }
s.source       = { :git => "https://github.com/Merculet/UAViOSSDK.git", :tag => '1.1.4.2' }
s.platform     = :ios
s.ios.deployment_target = "7.0"
s.requires_arc = true
s.ios.vendored_frameworks = 'Products/MagicWindowUAVSDK.framework'
s.frameworks = "AdSupport","CoreTelephony","CoreFoundation","SystemConfiguration","WebKit"
s.resource_bundles = { 'MagicWindowUAVSDK' => ['Products/MWSDKResource.bundle']}
s.library   = "c++"
end
