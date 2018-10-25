#
# Be sure to run `pod lib lint GBFloatingTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GBFloatingTextField'
  s.version          = '0.2.1'
  s.summary          = 'GBFloatingTextField is a Floting TextField.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
GBFloatingTextField is a Floting TextField. Which also contains Left Image and Right Image. You also perform actions on Both Images.
                       DESC

  s.homepage         = 'https://github.com/GurinderBatth/GBFloatingTextField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Gurinder Batth' => 'mr.gsbatth@gmail.com' }
  s.source           = { :git => 'https://github.com/GurinderBatth/GBFloatingTextField.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'GBFloatingTextField/Classes/**/*'
  
  s.swift_version = '3.2'
  
  # s.resource_bundles = {
  #   'GBFloatingTextField' => ['GBFloatingTextField/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
