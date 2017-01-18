public  extension Test {
  /// Just emits a passing `TestPoint`.
  ///
  /// ```swift
  /// tape.test(plan: 1) { t in
  ///   t.pass()
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  public func pass(
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let message = message ?? "pass"
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(TestPoint(
      isOk: true,
      message: message,
      source: location
    ))
  }

  /// A curried version of `pass`. Just emits a passing `TestPoint`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("just emits", timeout: 0.01) { t in
  ///   Observable.just(3).test(
  ///     onNext: t.pass(with: "just emits"),
  ///     onError: t.fail(with: "just won't throw'")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  public func pass<T>(
    with message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (T) -> Void {
    return { _ in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(TestPoint(
        isOk: true,
        message: message,
        source: location
      ))
    }
  }
}
