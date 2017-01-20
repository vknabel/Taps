import RxSwift
import TestHarness

public protocol OfferingTaps {
  var testCaseObserver: AnyObserver<RawTestCase> { get }
}

public protocol OfferingRxTaps: OfferingTaps {}

public protocol OfferingTests {
  var report: AnyObserver<TestPoint> { get }
}