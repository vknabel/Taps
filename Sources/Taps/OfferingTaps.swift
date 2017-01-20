import RxSwift
import TestHarness

/// The protocol, all `TestCase` entry points will be defined on.
public protocol OfferingTaps {
  /// The observer to post your `TestCase` on.
  var testCaseObserver: AnyObserver<TestCase> { get }
}

/// The protocol, all Rx `TestCase` entry points will be defined on.
public protocol OfferingRxTaps: OfferingTaps {}

/// The protocol, all `TestPoint`s will be defined on.
public protocol OfferingTests {
  /// The observer to post your `TestPoint` on.
  var report: AnyObserver<TestPoint> { get }
}
