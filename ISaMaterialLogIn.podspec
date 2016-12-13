#
# Be sure to run `pod lib lint ISaMaterialLogIn.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ISaMaterialLogIn'
  s.version          = '0.1.0'
  s.summary          = 'A Login/SignUp ViewController with Material Design animations and error handling!’

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ISaMaterialLogIn + CosmicMind/Material is a Material Design Login/Signup ViewController for iOS created with CosmicMind/Material library: https://github.com/CosmicMind/Material.
                       DESC

  s.homepage         = 'https://github.com/FraDeliro/ISaMaterialLogIn'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'FraDeliro' => 'fra.prove@libero.it' }
  s.source           = { :git => 'https://github.com/FraDeliro/ISaMaterialLogIn.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/FDeliro'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ISaMaterialLogIn/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ISaMaterialLogIn' => ['ISaMaterialLogIn/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'Material', '~> 2.0'
end
