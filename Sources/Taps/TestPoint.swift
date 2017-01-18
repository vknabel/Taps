import TestHarness

/// Test Points represent the result of one single assertion.
public struct TestPoint: AutoEquatable {
  internal let isOk: Bool
  internal let message: String?
  internal let details: [String: Yaml]?
  internal let sourceLocation: SourceLocation

  /// Creates a Test Point with the given options.
  ///
  /// - Parameter isOk: Indicates wether the point succeeded.
  /// - Parameter message: An optional message that will be printed.
  /// - Parameter details: A Yaml of details to be displayed.
  public init(
    isOk: Bool,
    message: String?,
    source location: SourceLocation,
    details: [String: Yaml]? = nil
  ) {
    self.isOk = isOk
    self.message = message
    self.details = details
    self.sourceLocation = location
  }
}
