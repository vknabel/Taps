public  extension Test {
  public func pass(
    message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) {
    let message = message ?? "pass"
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    report.onNext(TestPoint(
      isOk: true,
      message: message,
      source: location
    ))
  }

  public func pass<T>(
    message: String? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
  ) -> (T) -> Void {
    return { _ in
      let location = SourceLocation(file: file, line: line, column: column, function: function)
      self.report.onNext(TestPoint(
        isOk: true,
        message: message,
        source: location
      ))
    }
  }
}
