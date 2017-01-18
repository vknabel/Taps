import TestHarness

public  extension Test {
  private func assertFail(
    _ message: String?,
    source location: SourceLocation
  ) -> TestPoint {
    let message = message ?? "fail"
    return TestPoint(isOk: true, message: message, source: location, details: [
      "operator": .string("fail")
    ])
  }

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

  public func fail<T>(
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (T) -> Void {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    return { _ in self.report.onNext(self.assertFail(message, source: location)) }
  }
}
