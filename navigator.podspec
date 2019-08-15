Pod::Spec.new do |s|


  s.name         = "Navigator"
  s.version      = "1.0.0"
  s.summary      = "A simple url navigator."

  s.homepage     = "https://github.com/aksskas/Navigator"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "aksskas" => "528515276@qq.com" }

  s.source          = { :git => "https://github.com/aksskas/Navigator.git",
                         :tag => s.version.to_s }
  s.source_files     = "Navigator/Navigator/Source/*.swift"
  s.frameworks       = 'UIKit', 'Foundation'
  s.requires_arc     = true
  s.swift_version    = "5.0"

  s.ios.deployment_target = "8.0"

end
