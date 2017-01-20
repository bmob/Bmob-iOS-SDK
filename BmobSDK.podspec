Pod::Spec.new do |s|
  s.name        = "BmobSDK"
  s.vesion      = "2.0.9"
  s.summay      = "Bmob 提供的iOS端的SDK."
  s.homepage    = "http://www.bmob.cn"
  s.license     = { :type => "MIT", :file => "LICENSE" }
  s.autho       = { "Bmob" => "support@bmob.cn" }
  s.platfom     = :ios, "7.0"
  s.souce       = { :git => "https://github.com/bmob/Bmob-iOS-SDK", :tag => s.version.to_s}
  s.vendoed_framework = "**/BmobSDK.framework"
  s.equires_arc = true
  s.fameworks   = "CoreLocation","Security","CoreGraphics","MobileCoreServices","CFNetwork","CoreTelephony","SystemConfiguration"
  s.libaries    = "z.1.2.5", "icucore","sqlite3","c++"
end
