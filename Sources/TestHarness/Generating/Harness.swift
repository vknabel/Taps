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
public struct TestHarness {
  public let handler: (TestOutput) -> Void

  public init(handler: @escaping (TestOutput) -> Void) {
    self.handler = handler
  }
}

public enum TestOutput: AutoEquatable {
  case version(Int)
  case plan(expected: Int, message: String?)
  case testPoint(ok: Bool, count: Int?, message: String?, directive: Directive?, details: Yaml?)
  case diagnostic(String)
  case unknown(String)
  case bailOut(String?)
}
