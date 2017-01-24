import RxSwift
import TestHarness
@testable import Taps

private struct SubjectOfferingTaps: OfferingTaps {
  let testCases = ReplaySubject<TestCase>.createUnbounded()
  var testCaseObserver: AnyObserver<TestCase> {
    return AnyObserver(testCases)
  }
}

extension RxTaps {
  func mockingTest<T>(
    _ title: String? = nil,
    plan: Int? = nil,
    against tester: @escaping (OfferingTests) -> Void,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    timeout interval: RxTimeInterval? = nil,
    scheduler: SchedulerType? = nil,
    with observable: @escaping (OfferingTests, Observable<TestPoint>) -> Observable<T>
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    let points = ReplaySubject<TestPoint>.createUnbounded()
    let mocked = Test(report: points.asObserver(), plan: plan)
    self.genericTest(
      title,
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

  func mockedTestCase<T>(
    _ title: String? = nil,
    plan: Int? = nil,
    against tester: @escaping (OfferingTaps) -> Void,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    timeout interval: RxTimeInterval? = nil,
    scheduler: SchedulerType? = nil,
    with observable: @escaping (OfferingTests, Observable<TestCase>) -> Observable<T>
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    let mocked = SubjectOfferingTaps()
    self.genericTest(
      title,
      source: location,
      timeout: interval,
      scheduler: scheduler
    ) { t -> Observable<T> in
      defer { tester(mocked) }
      if let plan = plan {
        return observable(t, mocked.testCases.take(plan))
      } else {
        return observable(t, mocked.testCases)
      }
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
