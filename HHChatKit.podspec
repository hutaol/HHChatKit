#
# Be sure to run `pod lib lint HHChatKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HHChatKit'
  s.version          = '0.1.11'
  s.summary          = '使用SocketRocket聊天库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hutaol/HHChatKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Henry' => '1325049637@qq.com' }
  s.source           = { :git => 'https://github.com/hutaol/HHChatKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HHChatKit/Classes/**/*'
  
#   s.resource_bundles = {
#     'HHChatKit' => ['HHChatKit/Assets/*.png']
#   }

  s.resources   = 'HHChatKit/Assets/*.{png,xib,nib,bundle}'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.vendored_libraries = "HHChatKit/Classes/Lame/libmp3lame.a"

  s.dependency 'SocketRocket', '~> 0.5.1'
  s.dependency 'YYModel', '~> 1.0.4'
  s.dependency 'SDWebImage', '~> 5.8.4'
  s.dependency 'YBImageBrowser', '~> 3.0.9'
  s.dependency 'ZLPhotoBrowser', '~> 3.2.0'

end
