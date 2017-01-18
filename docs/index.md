# Taps

Taps is a lightweight Unit Test library optimized for asynchronous code and generating [TAP13](https://testanything.org/tap-version-13-specification.html) compatible output.



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
