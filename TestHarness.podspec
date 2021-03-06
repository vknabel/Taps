Pod::Spec.new do |s|

  s.name         = "TestHarness"
  s.version      = "0.1.0"
  s.summary      = "TestHarness serves a datastructure for TAP13 compatible output."

  s.description  = <<-DESC
                 TestHarness implements a data structure to represent TAP13 output and serves a simple printer for it.
                   DESC

  s.homepage     = "https://github.com/vknabel/Taps"
  s.license      = 'MIT'
  s.author       = { "Valentin Knabel" => "taps@vknabel.com" }
  s.social_media_url = "https://twitter.com/vknabel"

  s.source           = { :git => 'https://github.com/vknabel/Taps.git', :tag => s.version.to_s }
  s.source_files = 'Sources/TestHarness/**/*.swift'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
	s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.pod_target_xcconfig =  {
    'SWIFT_VERSION' => '3.0',
  }

  s.dependency 'RxSwift', '~>3.0'
  s.dependency 'RxBlocking', '~>3.0'
end
