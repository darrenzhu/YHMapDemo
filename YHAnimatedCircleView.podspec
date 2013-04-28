Pod::Spec.new do |s|
  s.name         = "YHAnimatedCircleView"
  s.version      = "0.0.1"
  s.summary      = "A clone of YHMapDemo."
  s.homepage     = "https://github.com/yickhong/YHMapDemo"
  s.license      = 'MIT'
  s.author       = { "Bradley Campbell" => "grandstaish@gmail.com" }
  s.source       = { :git => "https://github.com/grandstaish/YHMapDemo.git", commit: "a8f4bba17bfc8e588e125f9add21cd75969dff3e" }
  s.platform     = :ios, '5.0'
  s.source_files = 'YHMapDemo/YHMapDemo/YHAnimatedCircleView.{h,m}'
  s.exclude_files = 'Classes/Exclude'
  s.frameworks = 'MapKit', 'QuartzCore'
  s.requires_arc = true
end
