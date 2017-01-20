import RxSwift
import TestHarness

public extension OfferingTaps {
  /// A tester for potentially throwing tests.
  ///
  /// - Parameter test: The name of the test.
  /// - Parameter plan: The amount of expected `TestPoint`s.
  ///     Will automatically call `TestPoint.end` if all planned tests have been run.
  /// - Parameter directive: The `Directive` that shall be applied. If `TestPoint`s fail, they won't break the build.
  /// - Parameter timeout: The interval defining the maximum duration the test may need.
  /// - Parameter scheduler: The scheduler for the test. Visit RxSwift for more info.
  /// - Parameter test: A function that runs your tests.
  public func test(
    _ title: String? = nil,
    plan: Int? = nil,
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function,
    timeout interval: RxTimeInterval? = nil,
    scheduler: SchedulerType? = nil,
    with tests: @escaping (Test) throws -> Void
  ) {
    let location = SourceLocation(file: file, line: line, column: column, function: function)
    rx.assertionTest(
      title,
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
