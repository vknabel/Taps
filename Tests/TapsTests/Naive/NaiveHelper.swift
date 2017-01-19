import RxSwift
import TestHarness
@testable import Taps

extension RxTaps {
  func mockingTest<T>(
    _ title: String? = nil,
    plan: Int? = nil,
    against tester: @escaping (Test) -> Void,
    directive: Directive? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    timeout interval: RxTimeInterval? = nil,
    scheduler: SchedulerType? = nil,
    with observable: @escaping (Test, Observable<TestPoint>) -> Observable<T>
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    let points = ReplaySubject<TestPoint>.createUnbounded()
    let mocked = Test(report: points.asObserver(), plan: plan)
    self.genericTest(
      title,
      directive: directive,
      source: location,
      timeout: interval,
      scheduler: scheduler
    ) { t -> Observable<T> in
      let source = Observable.deferred { () -> Observable<TestPoint> in
        defer { tester(mocked) }
        return points.asObservable()
      }
      return observable(t, source)
    }
  }
}

struct SomeError: Error { }
struct AnotherError: Error { }

extension TestPoint {
  static func isOk(_ point: TestPoint) -> Bool {
    return point.isOk
  }
}
