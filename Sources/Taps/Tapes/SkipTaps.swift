import RxSwift
import TestHarness

private struct SkipTaps: OfferingTaps {
  let testCaseObserver: AnyObserver<TestCase>

  init(offering taps: OfferingTaps, message: String?) {
    testCaseObserver = taps.testCaseObserver.mapObserver { testCase in
      guard testCase.directive == nil else { return testCase }
      var testCase = testCase
      testCase.directive = Directive(kind: .skip, message: message)
      testCase.observable = Observable.empty
      return testCase
    }
  }
}

public extension OfferingTaps {
  /// All tests defined inside the use of directive will be skipped.
  public func skip(_ message: String) -> OfferingTaps {
    return SkipTaps(offering: self, message: message)
  }

  /// All tests defined inside the use of directive will be skipped.
  public var skip: OfferingTaps {
    return SkipTaps(offering: self, message: nil)
  }
}
