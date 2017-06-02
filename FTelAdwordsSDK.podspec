#
#  Be sure to run `pod spec lint FTelAdwordsSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name             = "FTelAdwordsSDK"
  s.summary          = "FTelAdwordsSDK help to place an adwords easy"
  s.version          = "1.0"
  s.homepage         = "https://github.com/laidungtr/"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "DUNGLAI" => "laidungtr@gmail.com" }
  s.source           = {
    :git => "https://github.com/laidungtr/FTelAdwordsSDK.git",
    :commit => "2fcbc481f4b1415c2efc9f10ade02733fba50af9",
    :tag => 1.0
  }

  s.ios.deployment_target = '8.0'

  s.requires_arc = true
  s.ios.source_files = 'FTelAdwordsSDK/**/*.{h,m,swift}'

  s.ios.frameworks = 'UIKit', 'Foundation'

  s.description  = "An SDK to place adwords easy it only use for personal and wont support for anything else"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
