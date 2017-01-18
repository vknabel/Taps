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
