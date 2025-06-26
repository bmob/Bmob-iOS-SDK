Pod::Spec.new do |s|

  s.name        = "BmobSDK"
  s.version      = "2.5.625"
  s.summary      = "Bmob 官方提供的iOS端的SDK."
  s.homepage     = "http://www.bmobapp.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Bmob" => "730170034@qq.com" }
  s.platform     = :ios, "12.0"
  s.source       = { :git => "https://github.com/bmob/Bmob-iOS-SDK.git", :tag => "2.5.626"}
  s.pod_target_xcconfig = {'ENABLE_PREVIEWS' => 'NO','SWIFT_VERSION' => '5.0' }
  s.vendored_frameworks = "BmobSDK_xcframework/BmobSDK.xcframework"
  s.requires_arc = true
  s.frameworks  = "CoreLocation","Security","CoreGraphics","MobileCoreServices","CFNetwork","CoreTelephony","SystemConfiguration","Photos"
  s.libraries   = "z.1.2.5", "icucore","sqlite3","c++"

end