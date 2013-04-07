Pod::Spec.new do |s|
  s.name         = "YHAnimatedCircleView"
  s.version      = "0.0.1"
  s.summary      = "A short description of YHAnimatedCircleView."
  s.homepage     = "https://github.com/yickhong/YHMapDemo"
  s.license      = 'MIT (example)'
  s.author       = { "Bradley Campbell" => "grandstaish@gmail.com" }
  s.source       = { :git => "https://github.com/grandstaish/YHMapDemo.git", :tag => "0.0.1" }
  s.platform     = :ios, '5.0'
  s.source_files = 'YHMapDemo/YHMapDemo/YHAnimatedCircleView.h, YHMapDemo/YHMapDemo/YHAnimatedCircleView.m'
  s.exclude_files = 'Classes/Exclude'
  s.frameworks = 'MapKit', 'QuartzCore'
  s.requires_arc = true
end
