import RxSwift
import TestHarness

fileprivate extension ObservableType {
  func timeout(_ interval: RxTimeInterval?, scheduler: SchedulerType? = nil) -> Observable<E> {
    guard let interval = interval else { return asObservable() }
    return self.timeout(interval, scheduler: scheduler ?? MainScheduler.instance)
  }
}

internal struct FactoryTestCase {
  let title: String
  let directive: Directive?
  let source: SourceLocation
  let factory: () -> Observable<TestPoint>

  internal init(
    title: String,
    directive: Directive?,
    source location: SourceLocation,
    factory: @escaping () -> Observable<TestPoint>
  ) {
    self.title = title
    self.directive = directive
    self.source = location
    self.factory = factory
  }

  internal init(raw: TestCase) {
    self.title = raw.title ?? "(anonymous)"
    self.directive = raw.directive
    self.source = raw.sourceLocation
    self.factory = {
      return Observable.deferred(raw.observable)
        .timeout(raw.timeoutInterval, scheduler: raw.scheduler)
    }
  }
}

/// A lazy group of `TestPoint`s. Sometimes called Taps.
public struct TestCase {
  /// The title of the test case.
  public var title: String?
  /// The directive of the test case.
  public var directive: Directive?
  /// The source location of the test case.
  public var sourceLocation: SourceLocation
  /// The maximum execution duration.
  public var timeoutInterval: RxTimeInterval?
  /// The scheduler that shall be used for the test.
  public var scheduler: SchedulerType?
  /// A factory of all `TestPoint`s.
  public var observable: () -> Observable<TestPoint>

  /// Creates a new `TestCase`.
  ///
  /// - Parameter title: The title of the test case.
  /// - Parameter directivr: The directive of the test case.
  /// - Parameter location: The `SourceLocation` of the test case.
  /// - Parameter interval: The maximum execution duration of the test case.
  /// - Parameter scheduler: The scheduler that shall be used for the test.
  /// - Parameter observable: A factory of all `TestPoint`s.
  public init(
    title: String?,
    directive: Directive? = nil,
    source location: SourceLocation,
    timeout interval: RxTimeInterval?,
    scheduler: SchedulerType?,
    with observable: @escaping () -> Observable<TestPoint>
  ) {
    self.title = title
    self.directive = directive
    self.sourceLocation = location
    self.timeoutInterval = interval
    self.scheduler = scheduler
    self.observable = observable
  }
}
