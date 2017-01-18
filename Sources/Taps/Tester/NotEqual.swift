import TestHarness

public extension Test {
  private func assertNotEqual<T: Equatable>(
    _ given: T,
    _ expected: T,
    message: String?,
    source location: SourceLocation
  ) -> TestPoint {
    let message = message ?? "are not equal"
    if given != expected {
      return TestPoint(isOk: true, message: message, source: location)
    } else {
      return TestPoint(isOk: false, message: message, source: location, details: [
        "operator": .string("not equal"),
        "expected": .string(String(describing: expected)),
        "actual": .string(String(describing: given))
      ])
    }
  }

  /// Emits a `TestPoint`, that passes if both values are not equal.
  ///
  /// ```swift
  /// tape.test("test equality", plan: 1) { t in
  ///   t.notEqual(1, 2, "no false positives")
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  public func notEqual<T: Equatable>(
    _ given: T,
    _ expected: T,
    message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertNotEqual(given, expected, message: message, source: location))
  }

  /// A curried version of `Test.notEqual`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("just emits", timeout: 0.01) { t in
  ///   Observable.just(3)
  ///     .map { $0 + 1 }
  ///     .test(
  ///       onNext: t.notEqual(to: 3, "just emits 3"),
  ///       onError: t.fail(with: "just won't throw'")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter expected: The expected value.
  /// - Parameter message: The message for the test.
  public func notEqual<T: Equatable>(
    to expected: T,
    message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (T) -> Void {
    return { given in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertNotEqual(given, expected, message: message, source: location))
    }
  }
}
