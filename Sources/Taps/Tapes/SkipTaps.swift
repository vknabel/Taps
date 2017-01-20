import RxSwift
import TestHarness

public struct SkipTaps: OfferingTaps {
  public let testCaseObserver: AnyObserver<TestCase>

  fileprivate init(offering taps: OfferingTaps, message: String?) {
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
  public func skip(_ message: String? = nil) -> SkipTaps {
    return SkipTaps(offering: self, message: message)
  }

  public var skip: SkipTaps {
    return SkipTaps(offering: self, message: nil)
  }
}
