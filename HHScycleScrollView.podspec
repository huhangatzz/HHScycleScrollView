
Pod::Spec.new do |spec|

  spec.name         = "HHScycleScrollView"
  spec.version      = "1.0.0"
  spec.summary      = "A iOS Unlimited rotation function."
  spec.homepage     = "https://github.com/huhangatzz/HHScycleScrollView"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' } 
  spec.author       = { "白天不懂夜的黑" => "1107313299@qq.com" }
  spec.source       = { :git => "https://github.com/huhangatzz/HHScycleScrollView.git", :tag => "1.0.0" }
  spec.requires_arc = true  
  spec.frameworks = 'UIKit'

  spec.source_files = 'HHScycleScrollView/HHScycleScrollView/HHScycleView/*.{h,m}'

end
