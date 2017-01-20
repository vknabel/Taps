import TestHarness

public  extension OfferingTests {
  private func assertNotOk<T>(
    _ message: String?,
    source location: SourceLocation,
    test: T,
    predicate: (T) -> Bool
  ) -> TestPoint {
    let message = message ?? "is not ok"
    if !predicate(test) {
      return TestPoint(isOk: true, message: message, source: location)
    } else {
      return TestPoint(isOk: false, message: message, source: location, details: [
        "operator": .string("not ok"),
        "given": .string(String(describing: test))
      ])
    }
  }

  /// Emits a passing `TestPoint` if test is false.
  ///
  /// ```swift
  /// tape.test("test array is not empty", plan: 1) { t in
  ///   t.notOk([1].isEmpty, "[1] is not empty")
  /// }
  /// ```
  ///
  /// - Parameter test: The value to be tested.
  /// - Parameter message: The message for the test.
  public func notOk(
    _ test: Bool,
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertNotOk(message, source: location, test: test, predicate: { $0 }))
  }

  /// Emits a passing `TestPoint` if test is nil.
  ///
  /// ```swift
  /// tape.test("test empty array first", plan: 1) { t in
  ///   t.notOk([].first, "[] has no first")
  /// }
  /// ```
  ///
  /// - Parameter test: The value to be tested.
  /// - Parameter message: The message for the test.
  public func notOk<T>(
    _ test: T?,
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertNotOk(message, source: location, test: test, predicate: { $0 != nil }))
  }

  /// A curried version of `Test.notOk`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("first emits once", timeout: 0.01) { t in
  ///   Observable.of(0, 1).first.test(
  ///     onNext: t.notOk(matches: { $0 >= 0 }),
  ///     onError: t.fail(with: "of().first won't throw'")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  /// - Parameter predicate: The predicate for the value.
  public func notOk<T>(
    with message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    matches predicate: @escaping (T) -> Bool
  ) -> (T) -> Void {
    return { value in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertNotOk(message, source: location, test: value, predicate: predicate))
    }
  }

  /// A curried version of `Test.ok`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("first emits once", timeout: 0.01) { t in
  ///   Observable.of(false, true).first.test(
  ///     onNext: t.notOk(with: "only emits false"),
  ///     onError: t.fail(with: "of().first won't throw'")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  /// - Parameter predicate: The predicate for the value.
  public func notOk(
    with message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (Bool) -> Void {
    return { value in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertNotOk(message, source: location, test: value, predicate: { $0 }))
    }
  }

  /// A curried version of `Test.notOk`. Useful for `Observable`s.
  ///
  /// ```swift
  /// tape.test("first emits once", timeout: 0.01) { t in
  ///   Observable.of(nil, 1).first.test(
  ///     onNext: t.notOk(with: "won't emit nil"),
  ///     onError: t.fail(with: "of().first won't throw'")
  ///   )
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  /// - Parameter predicate: The predicate for the value.
  public func notOk<T>(
    with message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (T?) -> Void {
    return { value in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertNotOk(message, source: location, test: value, predicate: { $0 != nil }))
    }
  }
}
