#
# Be sure to run `pod lib lint MYChatUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MYChatUIKit'
  s.version          = '0.5.0'
  s.summary          = 'MYChatUIKit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/fengkuangdeshitou/MYChatUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fengkuangdeshitou' => '409744573@qq.com' }
  s.source           = { :git => 'https://github.com/fengkuangdeshitou/MYChatUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.source_files = 'MYChatUIKit/Classes/**/*'
  s.resource = 'MYChatUIKit/Assets/**/*'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  s.public_header_files = 'MYChatUIKit/MYChatUIKit-Swift.h'
  
  s.dependency 'NEChatKit'
  s.dependency 'NECommonUIKit'
  s.dependency 'NECommonKit'
  s.dependency 'MJRefresh'
  s.dependency 'SDWebImageWebPCoder'
  s.dependency 'SDWebImageSVGKitPlugin'
  s.dependency 'lottie-ios','2.5.3'
  
end
