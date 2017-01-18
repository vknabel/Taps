/// Test Count contains some statistics regarding already ran tests.
public struct TestCount: AutoEquatable {
  /// The amount of how many tests have passed.
  public let passes: Int
  /// The amount of how many tests have failed.
  /// Tests that where skipped or were marked as todo count as passed.
  public let failures: Int
  /// The amount of all tests that have been run yet.
  public var tests: Int {
    return passes + failures
  }

  internal init(passes: Int = 0, failures: Int = 0) {
    self.passes = passes
    self.failures = failures
  }

  internal func state(for point: TestPoint, testCase: TestCase) -> TestCount {
    switch (point.isOk, testCase.directive) {
    case (true, _), (false, .some(_)):
      return .init(passes: passes + 1, failures: failures)
    default:
      return .init(passes: passes, failures: failures + 1)
    }
  }
}
