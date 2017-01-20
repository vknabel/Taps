import TestHarness

public extension OfferingTests {
  private func assertEqual<T: Equatable>(
    _ given: T,
    _ expected: T,
    message: String?,
    source location: SourceLocation
  ) -> TestPoint {
    let message = message ?? "are equal"
    if given == expected {
      return TestPoint(isOk: true, message: message, source: location)
    } else {
      return TestPoint(isOk: false, message: message, source: location, details: [
        "operator": .string("equal"),
        "expected": .string(String(describing: expected)),
        "actual": .string(String(describing: given))
      ])
    }
  }

  /// Emits a `TestPoint`, that passes if both values are equal.
  ///
  /// ```swift
  /// tape.test("test equality reflexiveness", plan: 1) { t in
  ///   t.equal(2, 2, "must be reflexive")
  /// }
  /// ```
  ///
  /// - Parameter given: The value to be tested.
  /// - Parameter expected: The value to be compared against.
  /// - Parameter message: The message for the test.
  public func equal<T: Equatable>(
    _ given: T,
    _ expected: T,
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertEqual(given, expected, message: message, source: location))
  }

  /// A curried version of `Test.equal`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("just emits", timeout: 0.01) { t in
  ///   Observable.just(3).test(
  ///     onNext: t.equal(to: 3, "just emits 3"),
  ///     onError: t.fail(with: "just won't throw'")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter expected: The expected value.
  /// - Parameter message: The message for the test.
  public func equal<T: Equatable>(
    to expected: T,
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (T) -> Void {
    return { given in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertEqual(given, expected, message: message, source: location))
    }
  }
}
