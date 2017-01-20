import TestHarness

public  extension OfferingTests {
  private func assertOk<T>(
    _ message: String?,
    source location: SourceLocation,
    test: T,
    predicate: (T) -> Bool
  ) -> TestPoint {
    let message = message ?? "is ok"
    if predicate(test) {
      return TestPoint(isOk: true, message: message, source: location)
    } else {
      return TestPoint(isOk: false, message: message, source: location, details: [
        "operator": .string("ok"),
        "given": .string(String(describing: test))
      ])
    }
  }

  /// Emits a passing `TestPoint` if test is true.
  ///
  /// ```swift
  /// tape.test("test array is empty", plan: 1) { t in
  ///   t.ok([].isEmpty, "[] is empty")
  /// }
  /// ```
  ///
  /// - Parameter test: The value to be tested.
  /// - Parameter message: The message for the test.
  public func ok(
    _ test: Bool,
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertOk(message, source: location, test: test, predicate: { $0 }))
  }

  /// Emits a passing `TestPoint` if test is not nil.
  ///
  /// ```swift
  /// tape.test("test array first", plan: 1) { t in
  ///   t.ok([1].first, "[1] has first")
  /// }
  /// ```
  ///
  /// - Parameter test: The value to be tested.
  /// - Parameter message: The message for the test.
  public func ok<T>(
    _ test: T?,
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertOk(message, source: location, test: test, predicate: { $0 != nil }))
  }

  /// A curried version of `Test.ok`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("first emits once", timeout: 0.01) { t in
  ///   Observable.of(1, 0).first.test(
  ///     onNext: t.ok(matches: { $0 >= 0 }),
  ///     onError: t.fail(with: "of().first won't throw'")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  /// - Parameter predicate: The predicate for the value.
  public func ok<T>(
    with message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    matches predicate: @escaping (T) -> Bool
  ) -> (T) -> Void {
    return { value in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertOk(message, source: location, test: value, predicate: predicate))
    }
  }

  /// A curried version of `Test.ok`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("first emits once", timeout: 0.01) { t in
  ///   Observable.of(true, false).first.test(
  ///     onNext: t.ok(with: "only emits true"),
  ///     onError: t.fail(with: "of().first won't throw'")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  /// - Parameter predicate: The predicate for the value.
  public func ok(
    with message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (Bool) -> Void {
    return { value in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertOk(message, source: location, test: value, predicate: { $0 }))
    }
  }

  /// A curried version of `Test.ok`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("first emits once", timeout: 0.01) { t in
  ///   Observable.of(1, nil).first.test(
  ///     onNext: t.ok(with: "won't emit nil"),
  ///     onError: t.fail(with: "of().first won't throw'")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  /// - Parameter predicate: The predicate for the value.
  public func ok<T>(
    with message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (T?) -> Void {
    return { value in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertOk(message, source: location, test: value, predicate: { $0 != nil }))
    }
  }
}
