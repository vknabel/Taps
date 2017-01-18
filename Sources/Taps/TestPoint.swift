import TestHarness

public struct TestPoint: AutoEquatable {
  internal let isOk: Bool
  internal let message: String?
  internal let details: [String: Yaml]?
  internal let sourceLocation: SourceLocation

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
