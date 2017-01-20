import RxSwift
import TestHarness

private struct TodoTaps: OfferingTaps {
  let testCaseObserver: AnyObserver<TestCase>

  init(offering taps: OfferingTaps, message: String?) {
    testCaseObserver = taps.testCaseObserver.mapObserver { testCase in
      guard testCase.directive == nil else { return testCase }
      var testCase = testCase
      testCase.directive = Directive(kind: .todo, message: message)
      return testCase
    }
  }
}

public extension OfferingTaps {
  /// All tests defined inside the use of directive will be marked as todo.
  /// If they fail, the test is marked as not ok, but as passing.
  public func todo(_ message: String) -> OfferingTaps {
    return TodoTaps(offering: self, message: message)
  }

  /// All tests defined inside the use of directive will be marked as todo.
  /// If they fail, the test is marked as not ok, but as passing.
  public var todo: OfferingTaps {
    return TodoTaps(offering: self, message: nil)
  }
}
