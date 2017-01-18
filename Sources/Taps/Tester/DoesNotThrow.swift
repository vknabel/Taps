import TestHarness

public extension Test {
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
      return TestPoint(isOk: true, message: message, source: location, details: [
        "operator": .string("does not throw"),
        "throwed": .string(String(describing: error))
      ])
    }
  }

  public func doesNotThrow<T>(
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    test: @autoclosure () throws -> T
  ) {
    report.onNext(assertDoesNotThrow(
      message,
      source: SourceLocation(file: file, line: line, column: column, function: function),
      test: test)
    )
  }
}
