# Taps

![Swift 3](https://img.shields.io/badge/swift-3.0-orange.svg?style=flat-square)
[![GitHub release](https://img.shields.io/github/release/vknabel/taps.svg?style=flat-square)](https://github.com/vknabel/taps/releases)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat-square)](https://github.com/apple/swift-package-manager)
![Plaforms](https://img.shields.io/badge/Platform-Linux|macOS|iOS|tvOS|watchOS-lightgrey.svg?style=flat-square)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/vknabel/rock/master/LICENSE)

Taps is a lightweight Unit Test library optimized for asynchronous code.
it has been implemented using RxSwift and therefore you can easily test your own Observables with ease.

As the generated output is [TAP13](https://testanything.org/tap-version-13-specification.html) compatible, you can easily customize it yourself.
You can either use Taps integrated TapsHarness or you can use the pod TestHarness to customize the output.

Currently it is under development.

## Example

```swift
func testExamples(t: Taps) {
  t.test("asynchronous test") { t in
    async {
      t.pass()
      t.end()
    }
  }

  t.test("synchronous test", plan: 1) { t in
    t.equal(someInt(), 1) // only
  }

  t.rx.test("reactive test") { t in
    let myService = MyService()
    return myService.someObservable()
      .test(
        onNext: t.equal(to: 3),
        onError: t.fail("should not throw")
      )
  }
}

Taps.run(tests: [
  testExamples
])
```

## License

Finite is available under the MIT license. See the LICENSE file for more info.
