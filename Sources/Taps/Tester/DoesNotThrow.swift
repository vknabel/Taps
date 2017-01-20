import TestHarness

public extension OfferingTests {
  private func assertDoesNotThrow<T>(
    _ message: String?,
    source location: SourceLocation,
    test: () throws -> T
  ) -> TestPoint {
    let message = message ?? "does not throw"
    do {
      _ = try test()
      return TestPoint(isOk: true, message: message, source: location)
    } catch {
      return TestPoint(isOk: false, message: message, source: location, details: [
        "operator": .string("does not throw"),
        "throwed": .string(String(describing: error))
      ])
    }
  }

  private func assertDoesNotThrow<T, E: Error>(
    of kind: E.Type,
    _ message: String?,
    source location: SourceLocation,
    test: () throws -> T
  ) -> TestPoint {
    let message = message ?? "does not throw"
    do {
      _ = try test()
      return TestPoint(isOk: true, message: message, source: location)
    } catch let error as E {
      return TestPoint(isOk: false, message: message, source: location, details: [
        "operator": .string("does not throw"),
        "throwed": .string(String(describing: error)),
        "kind": .string(String(describing: E.self))
      ])
    } catch {
      return TestPoint(isOk: true, message: message, source: location)
    }
  }

  /// Emits a passing `TestPoint` if no error will be thrown.
  ///
  /// ```swift
  /// tape.test("test does not throw on return", plan: 1) { t in
  ///   t.doesThrow("does throw is ok when throwing") {
  ///     return 1
  ///   }
  /// }
  /// ```
  ///
  /// - Parameter message: The message for the test.
  public func doesNotThrow<T>(
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    test: () throws -> T
  ) {
    report.onNext(assertDoesNotThrow(
      message,
      source: SourceLocation(file: file, line: line, column: column, function: function),
      test: test)
    )
  }

  /// Emits a passing `TestPoint` if an error will of another type will be thrown.
  ///
  /// ```swift
  /// struct MyError: Error { }
  /// struct AnotherError: Error { }
  /// tape.test("test does not throw on correct error type", plan: 1) { t in
  ///   t.doesNotThrow(MyError.self, "does not throw is ok when other type") {
  ///     throw AnotherError()
  ///   }
  /// }
  /// ```
  ///
  /// - Parameter kind: The kind of errors that are allowed for the test.
  /// - Parameter message: The message for the test.
  public func doesNotThrow<T, E: Error>(
    _ kind: E.Type,
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    test: () throws -> T
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertDoesNotThrow(of: E.self, message, source: location, test: test))
  }

  /// Emits a passing `TestPoint` if an error will of another type will be thrown.
  ///
  /// ```swift
  /// struct MyError: Error { }
  /// struct WrongError: Error { }
  /// tape.test("error doesn't emit other error'", plan: 1) { t in
  ///   Observable.error(WrongError())
  ///     .test(
  ///       onNext: t.fail(".error won't emit"),
  ///       onError: t.doesNotThrow(of: WrongError.self, with: "does not throw wrong type")
  ///     )
  /// }
  /// ```
  ///
  /// - Parameter kind: The kind of errors that are allowed for the test.
  /// - Parameter message: The message for the test.
  public func doesNotThrow<E: Error>(
    of kind: E.Type,
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (Error) -> Void {
    return { error in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(self.assertDoesNotThrow(of: E.self, message, source: location, test: { throw error }))
    }
  }
}
