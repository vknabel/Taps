# Taps

![Swift 3](https://img.shields.io/badge/swift-3.0-orange.svg?style=flat-square)
[![GitHub release](https://img.shields.io/github/release/vknabel/taps.svg?style=flat-square)](https://github.com/vknabel/taps/releases)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat-square)](https://github.com/apple/swift-package-manager)
![Plaforms](https://img.shields.io/badge/Platform-Linux|macOS|iOS|tvOS|watchOS-lightgrey.svg?style=flat-square)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/vknabel/rock/master/LICENSE)

Taps is a lightweight Unit Test library optimized for asynchronous code.
It has been implemented using RxSwift and therefore you can easily test your own Observables with ease,
but no RxSwift knowledge is needed.

As the generated output is [TAP13](https://testanything.org/tap-version-13-specification.html) compatible, you can easily customize it yourself.
You can either use Taps integrated TapsHarness or you can use the pod TestHarness to customize the output.

You'll find the autogenerated docs [here](https://vknabel.github.io/Taps/generated/master).
## Example

Taps assumes all tests to be concurrent. That said it is quite easy to run them:

```swift
taps.test("test async completion", timeout: 0.1) { t in
  DispatchQueue.global().async {
    t.pass()
    t.end() // this terminates the test
  }
}
```

But instead of always being forced to call the `t.end()` when testing synchronous code,
you can add a plan for all expected tests.

```swift
taps.test("test does not throw on return", plan: 1) { t in
  t.doesThrow("does throw is ok when throwing") {
    return 1
  }
}
```

Since Taps uses RxSwift under the hood it really shines, when it comes to testing `Observable`s.
If your tested `Observable` completes, the test will automatically be finished!

```swift
tape.test("just emits", timeout: 0.01) { t in
  Observable.just(3)
    .map { $0 + 1 }
    .test(
      onNext: t.notEqual(to: 3, "just emits 3"),
      onError: t.fail(with: "just won't throw'")
    )
}
```

## License

Finite is available under the MIT license. See the LICENSE file for more info.
