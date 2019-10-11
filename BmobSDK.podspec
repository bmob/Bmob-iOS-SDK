Pod::Spec.new do |s|

  s.name        = "BmobSDK"
  s.version      = "2.4.1"
  s.summary      = "Bmob 提供的iOS端的SDK."
  s.homepage     = "http://www.bmob.cn"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Bmob" => "support@bmob.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/bmob/Bmob-iOS-SDK.git", :tag => "2.4.1"}
  s.license              = { :type => "MIT", :file => "LICENSE" }
  s.vendored_framework = "**/BmobSDK.framework"
  s.requires_arc = true
  s.frameworks  = "CoreLocation","Security","CoreGraphics","MobileCoreServices","CFNetwork","CoreTelephony","SystemConfiguration","Photos"
  s.libraries   = "z.1.2.5", "icucore","sqlite3","c++"

end