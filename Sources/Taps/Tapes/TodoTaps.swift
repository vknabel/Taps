import RxSwift
import TestHarness

public struct TodoTaps: OfferingTaps {
  public let testCaseObserver: AnyObserver<RawTestCase>

  fileprivate init(offering taps: OfferingTaps, message: String?) {
    testCaseObserver = taps.testCaseObserver.mapObserver { testCase in
      guard testCase.directive == nil else { return testCase }
      var testCase = testCase
      testCase.directive = Directive(kind: .todo, message: message)
      return testCase
    }
  }
}

public extension OfferingTaps {
  public func todo(_ message: String? = nil) -> TodoTaps {
    return TodoTaps(offering: self, message: message)
  }

  public var todo: TodoTaps {
    return TodoTaps(offering: self, message: nil)
  }
}
