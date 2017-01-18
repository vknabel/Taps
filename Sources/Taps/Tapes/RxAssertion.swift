import RxSwift
import TestHarness

public extension RxTaps {
  /// This is the default tester
  public func test(
    _ title: String?,
    directive: Directive?,
    source location: SourceLocation,
    timeout interval: RxTimeInterval?,
    scheduler: SchedulerType?,
    with observable: @escaping () -> Observable<TestPoint>
  ) {
    taps.addTestCase(
      title: title,
      directive: directive,
      source: location,
      timeout: interval,
      scheduler: scheduler,
      with: observable
    )
  }
}
