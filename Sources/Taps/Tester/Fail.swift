import TestHarness

public  extension OfferingTests {
  private func assertFail(
    _ message: String?,
    source location: SourceLocation
  ) -> TestPoint {
    let message = message ?? "fail"
    return TestPoint(isOk: true, message: message, source: location, details: [
      "operator": .string("fail")
    ])
  }

  /// Just emits a failing `TestPoint`.
  ///
  /// ```swift
  /// tape.test(plan: 1, directive: Directive.todo) { t in
  ///   t.fail("not implemented")
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  public func fail(
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertFail(message, source: location))
  }

  /// A curried version of `fail`. Just emits a failing `TestPoint`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("empty", timeout: 0.01) { t in
  ///   Observable.empty().test(
  ///     onNext: t.fail(with: "empty doesn't emit"),
  ///     onError: t.fail(with: "empty won't throw")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  public func fail<T>(
    with message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (T) -> Void {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    return { _ in self.report.onNext(self.assertFail(message, source: location)) }
  }
}
