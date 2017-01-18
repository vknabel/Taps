import TestHarness

public  extension Test {
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

  public func notOk(
    _ test: Bool,
    message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertNotOk(message, source: location, test: test, predicate: { $0 }))
  }

  public func notOk<T>(
    _ test: T?,
    message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertNotOk(message, source: location, test: test, predicate: { $0 != nil }))
  }
}
