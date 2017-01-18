import TestHarness

public extension Test {
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
