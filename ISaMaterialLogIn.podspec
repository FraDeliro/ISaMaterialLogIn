
Pod::Spec.new do |s|
  s.name             = "ISaMaterialLogIn"
  s.version          = "0.1.0"
  s.summary          = "A Login/SignUp ViewController with Material Design animations and error handling!"

  s.homepage         = "https://github.com/FraDeliro/ISaMaterialLogIn"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "FraDeliro" => "fra.prove@libero.it" }
  s.source           = { :git => 'https://github.com/FraDeliro/ISaMaterialLogIn.git', :tag => s.version.to_s }
  # s.social_media_url = "https://twitter.com/FDeliro"

  s.ios.deployment_target = "9.0"

  s.source_files = "ISaMaterialLogIn/Classes/**/*"
  s.dependency 'Material', '~> 2.0'
end
