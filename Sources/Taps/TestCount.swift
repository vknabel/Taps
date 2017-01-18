public struct TestCount: AutoEquatable {
  public let passes: Int
  public let failures: Int
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
