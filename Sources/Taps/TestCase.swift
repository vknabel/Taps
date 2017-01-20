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

  internal init(raw: RawTestCase) {
    self.title = raw.title ?? "(anonymous)"
    self.directive = raw.directive
    self.source = raw.sourceLocation
    self.factory = {
      return Observable.deferred(raw.observable)
        .timeout(raw.timeoutInterval, scheduler: raw.scheduler)
    }
  }
}

public struct RawTestCase {
  public var title: String?
  public var directive: Directive?
  public var sourceLocation: SourceLocation
  public var timeoutInterval: RxTimeInterval?
  public var scheduler: SchedulerType?
  public var observable: () -> Observable<TestPoint>

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
