Pod::Spec.new do |s|

  s.name         = "Taps"
  s.version      = "0.1.0"
  s.summary      = "Taps is a lightweight Unit Test library optimized for asynchronous code and generating TAP13 compatible output."

  s.description  = <<-DESC
                 Taps is a lightweight Unit Test library optimized for asynchronous code.
                   * As the generated output is TAP13 compatible, you can easily customize it yourself.
                   * Taps has been implemented using RxSwift and therefore you can easily test your own Observables with ease.
                   * You can either use Taps integrated TapsHarness or you can use the pod TestHarness to customize the output.
                   DESC

  s.homepage     = "https://github.com/vknabel/Taps"
  s.documentation_url = "https://vknabel.github.io/Taps"
  s.license      = 'MIT'
  s.author       = { "Valentin Knabel" => "taps@vknabel.com" }
  s.social_media_url = "https://twitter.com/vknabel"

  s.source       = { :git => 'https://github.com/vknabel/Taps.git', :tag => s.version.to_s }
  s.source_files = 'Sources/Taps/**/*.swift'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
	s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.pod_target_xcconfig =  {
    'SWIFT_VERSION' => '3.0',
  }

  s.dependency 'RxSwift', '~>3.0'
  s.dependency 'RxBlocking', '~>3.0'
  s.dependency 'TestHarness', '0.0.1'
end
