import TestHarness

public extension Test {
  private func assertDoesThrow<T>(
    _ message: String?,
    source location: SourceLocation,
    test: () throws -> T
  ) -> TestPoint {
    let message = message ?? "does throw"
    do {
      let result = try test()
      return TestPoint(isOk: false, message: message, source: location, details: [
        "operator": .string("does throw"),
        "returned": .string(String(describing: result))
      ])
    } catch {
      return TestPoint(isOk: true, message: message, source: location)
    }
  }

  private func assertDoesThrow<T, E: Error>(
    of kind: E.Type,
    _ message: String?,
    source location: SourceLocation,
    test: () throws -> T
  ) -> TestPoint {
    let message = message ?? "does throw"
    do {
      let result = try test()
      return TestPoint(isOk: false, message: message, source: location, details: [
        "operator": .string("does throw"),
        "returned": .string(String(describing: result))
      ])
    } catch is E {
      return TestPoint(isOk: true, message: message, source: location)
    } catch {
      return TestPoint(isOk: false, message: message, source: location, details: [
        "operator": .string("does throw"),
        "throwed": .string(String(describing: error)),
        "kind": .string(String(describing: E.self))
      ])
    }
  }

  /// Emits a passing `TestPoint` if an error will be thrown.
  ///
  /// ```swift
  /// struct MyError: Error { }
  /// tape.test("test does throw on throw", plan: 1) { t in
  ///   t.doesThrow("does throw is ok when throwing") {
  ///     throw MyError()
  ///   }
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  public func doesThrow<T>(
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    test: () throws -> T
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertDoesThrow(message, source: location, test: test))
  }

  /// Emits a passing `TestPoint` if an error will of the correct type will be thrown.
  ///
  /// ```swift
  /// struct MyError: Error { }
  /// tape.test("test does throw on correct error type", plan: 1) { t in
  ///   t.doesThrow(MyError.self, "does throw is ok when correct type") {
  ///     throw MyError()
  ///   }
  /// }
  /// ```
  ///
  /// - Parameter kind: The kind of errors that are allowed for the test.
  /// - Parameter message: The message for the test.
  public func doesThrow<T, E: Error>(
    _ kind: E.Type,
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    test: () throws -> T
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertDoesThrow(of: E.self, message, source: location, test: test))
  }

  /// A curried version of `doesThrow`. Just emits a passing `TestPoint`. Useful for `Observable`s.
  ///
  /// ```swift
  /// struct MyError: Error { }
  /// tape.test("observable error emits same error", plan: 1) { t in
  ///   Observable.error(MyError())
  ///     .test(
  ///       onNext: t.fail(".error won't emit"),
  ///       onError: t.doesThrow(of: MyError.self, with: "does throw correct type")
  ///     )
  /// }
  /// ```
  ///
  /// - Parameter kind: The kind of errors that are allowed for the test.
  /// - Parameter message: The message for the test.
  public func doesThrow<E: Error>(
    of kind: E.Type,
    with message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (Error) -> Void {
    return { error in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertDoesThrow(of: E.self, message, source: location, test: { throw error }))
    }
  }
}
