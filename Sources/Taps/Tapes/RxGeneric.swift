import RxSwift
import TestHarness

public extension RxTaps {
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
