import TestHarness

public  extension Test {
  private func assertDoesThrow<T>(
    _ message: String?,
    source location: SourceLocation,
    test: () throws -> T
  ) -> TestPoint {
    let message = message ?? "does throw"
    do {
      let result = try test()
      return TestPoint(isOk: true, message: message, source: location, details: [
        "operator": .string("does throw"),
        "returned": .string(String(describing: result))
      ])
    } catch {
      return TestPoint(isOk: true, message: message, source: location)
    }
  }

  public func doesThrow<T>(
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    test: @autoclosure () throws -> T
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(assertDoesThrow(message, source: location, test: test))
  }
}
