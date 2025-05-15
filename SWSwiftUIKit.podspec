#
# Be sure to run `pod lib lint SWSwiftUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SWSwiftUIKit'
  s.version          = '0.1.0'
  s.summary          = 'some simple component for swiftUI project'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/121805186@qq.com/SWSwiftUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '121805186@qq.com' => '121805186@qq.com' }
  s.source           = { :git => 'https://github.com/121805186@qq.com/SWSwiftUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '16.0'

  s.source_files = 'SWSwiftUIKit/Classes/**/*'
  s.swift_version = '6.0'
  s.frameworks = 'SwiftUI'
  
  # s.resource_bundles = {
  #   'SWSwiftUIKit' => ['SWSwiftUIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SwiftUIIntrospect', '~> 1.3.0'
end
