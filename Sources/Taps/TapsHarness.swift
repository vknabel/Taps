import TestHarness

/*
TAP version 13
# (anonymous)
not ok 1 should be equal
  ---
    operator: equal
    expected: "boop"
    actual:   "beep"
  ...
# (anonymous)
ok 2 should be equal
ok 3 (unnamed assert)
# wheee
ok 4 (unnamed assert)

1..4
# tests 4
# pass  3
# fail  1
*/
/// sourcery: default-init
public struct TapsHarness {
    internal let report: (TapsOutput) -> Void

    public init(report: @escaping (TapsOutput) -> Void) {
      self.report = report
    }
}

/// sourcery: auto-equatable
public enum TapsOutput: Equatable {
    case started
    case testCase(String, directive: Directive?)
    case testPoint(TestPoint, count: TestCount, directive: Directive?)
    case finished(TestCount)
    case bailOut(String)

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
