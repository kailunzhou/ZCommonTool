Pod::Spec.new do |spec|
  spec.name             = "ZCommonTool"
  spec.version          = "0.0.6"
  spec.license          = "MIT"
  
  spec.summary          = "ZCommonTool summary"
  
  spec.platform         = :ios, "9.0"
  spec.swift_version    = "4.2"
  spec.homepage         = "https://github.com/kailunzhou/ZCommonTool"
  spec.author           = { "zklcode" => "372909335@qq.com" }
  spec.source           = { :git => "https://github.com/kailunzhou/ZCommonTool.git", :tag => "0.0.6" }
  spec.dependency       "MJRefresh",      "~> 3.5.0"
  spec.dependency       "MBProgressHUD",  "~> 1.2.0"
  spec.dependency       "BRPickerView",   "~> 2.6.8"
  
  #spec.source_files     = "Classes", "Modules/Classes/**/*.{h,m,swift}"
  #spec.resource_bundles = { 'CTResource' => ['Modules/Assets/*.png'] }
  spec.source_files      = 'Modules/Classes/**/*'
  spec.resource          = ['Modules/Assets/*.xcassets']
  
  
  # spec.public_header_files = "Classes/**/*.h"
  # spec.exclude_files = "Classes/Exclude"
  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  # Or just: spec.author    = "zklcode"
  # spec.authors            = { "zklcode" => "372909335@qq.com" }
  # spec.social_media_url   = "https://twitter.com/zklcode"
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"
  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"
  # spec.requires_arc = true
  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
end
