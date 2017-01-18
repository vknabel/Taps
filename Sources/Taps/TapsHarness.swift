import TestHarness

/// A `TapsHarness` handles all `TapsOutput` emitted by `Taps`.
/// This Harness is optimizes for `Taps`, whereas `TestHarness` supports all TAP compatible output.
///
/// sourcery: default-init
public struct TapsHarness {
  internal let report: (TapsOutput) -> Void

  /// Creates a `TapsHarness` using a `TapsOutput` handler.
  ///
  /// - Parameter report: Contains the logic of the harness.
  public init(report: @escaping (TapsOutput) -> Void) {
    self.report = report
  }
}

/// The output emitted by `Taps`.
/// It can be translated into `TestOutput` using `TapsHarnessFromTest` or interpreted by `TapsHarness`.
public enum TapsOutput: Equatable {
  /// `Taps` will from now on execute `Test`s and `TestPoint`s
  case started
  /// Marks the begin of a test case. See `Tape.test`.
  ///
  /// - Parameter title: The title of the test case.
  /// - Parameter directive: The directive for the test case.
  case testCase(String, directive: Directive?)
  /// Emitted when a test has emitted a `TestPoint`.
  ///
  /// - Parameter testPoint: The `TestPoint`.
  /// - Parameter count: All counts for passed and failed tests.
  /// - Parameter directive: The directive for the test point.
  case testPoint(TestPoint, count: TestCount, directive: Directive?)
  /// Emitted when all `Test`s have been processed. This is the last `TapsOutput`.
  ///
  /// - Parameter count: All counts for passed and failed tests.
  case finished(TestCount)
  /// Emitted when a test has crashed and `Taps` cannot proceed.
  ///
  /// - Parameter message: The reason for the bail out.
  case bailOut(String)

  /// :nodoc:
  public static func == (lhs: TapsOutput, rhs: TapsOutput) -> Bool {
    switch (lhs, rhs) {
    case (.started, .started):
      return true
    case let (.testCase(l0, directive: l1), .testCase(r0, directive: r1)):
      return l0 == r0 && l1 == r1
    case let (.testPoint(l0, count: l1, directive: l2), .testPoint(r0, count: r1, directive: r2)):
      return l0 == r0 && l1 == r1 && l2 == r2
    case let (.finished(l0), .finished(r0)):
      return l0 == r0
    case let (.bailOut(l0), .bailOut(r0)):
      return l0 == r0
    default:
      return false
    }
  }
}
