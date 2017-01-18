import RxSwift
import TestHarness

public extension RxTaps {
  /// A tester for common observables that will complete.
  ///
  /// - Parameter test: The name of the test.
  /// - Parameter directive: The `Directive` that shall be applied. If `TestPoint`s fail, they won't break the build.
  /// - Parameter timeout: The interval defining the maximum duration the test may need.
  /// - Parameter scheduler: The scheduler for the test. Visit RxSwift for more info.
  /// - Parameter observable: An `Observable` that runs your tests.
  public func test<T>(
    _ title: String? = nil,
    directive: Directive? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    timeout interval: RxTimeInterval? = nil,
    scheduler: SchedulerType? = nil,
    with observable: @escaping (Test) -> Observable<T>
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    test(
      title,
      directive: directive,
      source: location,
      timeout: interval,
      scheduler: scheduler
    ) {
      return Observable<TestPoint>.create { report in
        let points = ReplaySubject<TestPoint>.createUnbounded()
        let t = Test(report: points.asObserver(), plan: nil)

        let assertSubscription = points.asObservable().subscribe(report)
        let completionSubscription = observable(t).do(onCompleted: t.end).subscribe()

        return Disposables.create(with: {
          completionSubscription.dispose()
          assertSubscription.dispose()
        })
      }
    }
  }
}
