/// Represents the location of the callee, that requested a test.
public struct SourceLocation: AutoEquatable, AutoHashable {
  /// The callee's file path.
  public let file: String
  /// The callee's line number.
  public let line: Int
  /// The callee's column.
  public let column: Int
  /// The callee's function name.
  public let function: String

  /// Creates a new source location.
  public init(file: String, line: Int, column: Int, function: String) {
    self.file = file
    self.line = line
    self.column = column
    self.function = function
  }
}
