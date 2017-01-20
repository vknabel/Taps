import RxSwift
import TestHarness

public extension OfferingRxTaps {
  /// The default tester that takes a stream of `TestPoint`s.
  /// This is not meant to be called from inside your tests.
  /// Use it only for creating your own tester functions.
  ///
  /// - Parameter test: The name of the test.
  /// - Parameter directive: The `Directive` that shall be applied. If `TestPoint`s fail, they won't break the build.
  /// - Parameter location: The `SourceLocation` of the calle of the test.
  /// - Parameter timeout: The interval defining the maximum duration the test may need.
  /// - Parameter scheduler: The scheduler for the test. Visit RxSwift for more info.
  /// - Parameter observable: An `Observable` of your `TestPoint`s.
  public func assertionTest(
    _ title: String?,
    directive: Directive?,
    source location: SourceLocation,
    timeout interval: RxTimeInterval?,
    scheduler: SchedulerType?,
    with observable: @escaping () -> Observable<TestPoint>
  ) {
    testCaseObserver.onNext(
      RawTestCase(
        title: title,
        directive: directive,
        source: location,
        timeout: interval,
        scheduler: scheduler,
        with: observable
      )
    )
  }
}
