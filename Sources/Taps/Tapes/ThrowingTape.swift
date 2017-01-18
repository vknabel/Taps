import RxSwift
import TestHarness

public extension Taps {
  public func test(
    _ title: String? = nil,
    plan: Int? = nil,
    directive: Directive? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    timeout interval: RxTimeInterval? = nil,
    scheduler: SchedulerType? = nil,
    with tests: @escaping (Test) throws -> Void
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    rx.test(
      title,
      directive: directive,
      source: location,
      timeout: interval,
      scheduler: scheduler
    ) {
    return Observable<TestPoint>.create { report in
        let test = Test(report: report, plan: plan)
        do {
          try tests(test)
        } catch {
          report.onError(error)
        }
        return Disposables.create { }
      }
    }
  }
}
