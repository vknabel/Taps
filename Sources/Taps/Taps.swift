import RxSwift
import TestHarness
import RxBlocking
import Dispatch
import Foundation

#if os(Linux)
  import Glibc
#else
  import Darwin.libc
#endif

fileprivate extension ObservableType {
  func timeout(_ interval: RxTimeInterval?, scheduler: SchedulerType? = nil) -> Observable<E> {
    guard let interval = interval else { return asObservable() }
    return self.timeout(interval, scheduler: scheduler ?? MainScheduler.instance)
  }
}

/// This is the entry point for all of your tests.
/// Declare a function that takes `Tape` and write your tests!
/// In order to see how to test in detail see `Test`.
///
/// ```swift
/// func describeYourTestSubject(taps: Taps) {
///   taps.test("test property") { (t: Test)
///     // Test property in here...
///     t.end()
///   }
///
///   // more tests here...
/// }
///
/// // Starting tests
/// Tape.runMain(tests: [
///   describeYourTestSubject
/// ])
/// ```
///
/// If you want to test `Observable`s, use `RxTaps`.
public final class Taps {
  private let testCases = ReplaySubject<TestCase>.createUnbounded()
  private let testBag = DisposeBag()
  private let tapsScheduler = OperationQueueScheduler(operationQueue: {
    let queue = OperationQueue()
    queue.name = "Taps Queue"
    queue.maxConcurrentOperationCount = 1
    return queue
  }())
  private let harness: TapsHarness

  /// Creates a cold `Taps` instance using a `TapsHarness`,
  /// that won't start running `Test`s by default.
  ///
  /// - Parameter harness: The `TapsHarness` that shall be used. Uses `TapHarness.printHarness` by default.
  public init(harness: TapsHarness? = nil) {
    self.harness = harness ?? .printHarness
  }

  /// Returns an observable running all tests.
  /// Only emits one single or an error.
  public var runner: Observable<TestCount> {
    let report = self.harness.report
    return self.testCases
      .observeOn(tapsScheduler)
      .map({ testCase -> Observable<(TestCase, TestPoint)> in
        return Observable.deferred {
          report(.testCase(testCase.title, directive: testCase.directive))
          return testCase.factory()
        }
          .observeOn(self.tapsScheduler)
          .catchError({
            .of(TestPoint(
              isOk: false,
              message: "test point factories may not emit errors",
              source: testCase.source,
              details: [
                "operator": .string("taps checks"),
                "error": .string(String(describing: $0))
              ]
            ))
          })
          .map { (testCase, $0) }
      })
      .concat()
      .reduce(TestCount()) { state, testCaseAndPoint in
        let (testCase, testPoint) = testCaseAndPoint
        let newState = state.state(for: testPoint, testCase: testCase)
        report(.testPoint(testPoint, count: newState, directive: testCase.directive))
        return newState
      }
      .do(
        onNext: { report(.finished($0)) },
        onError: { report(.bailOut(String(describing: $0))) }
      )
  }

  /// Starts to execute all `Test`s for the current `Taps`.
  /// All tests will be interrupted on dispose.
  public func start() -> Disposable {
    return runner.subscribe()
  }

  /// Starts to execute all `Test`s for the current `Taps`.
  /// All tests run until all are finished.
  public func run() {
    return start().addDisposableTo(testBag)
  }

  /// Starts to execute all `Test`s for the current `Taps`.
  /// Thereafter, there won't be executed anything.
  /// Exits with 1 if there were errors.
  public func runMain() -> Never {
    do {
      guard let count = try runner.toBlocking().first() else {
        exit(1)
      }
      exit(count.failures == 0 && count.passes > 0 ? 0 : 1)
    } catch {
      // has been handled by harness
      exit(1)
    }
  }

  internal func addTestCase(
    title: String?,
    directive: Directive?,
    source location: SourceLocation,
    timeout interval: RxTimeInterval?,
    scheduler: SchedulerType?,
    with observable: @escaping () -> Observable<TestPoint>
  ) {
    self.testCases.onNext(
      TestCase(
        title: title ?? "(anonymous)",
        directive: directive,
        source: location,
        factory: {
          return Observable.deferred(observable)
            .timeout(interval, scheduler: scheduler)
        }
      )
    )
  }

  /// Creates a cold `Taps`, that executes all given `Test`s.
  /// Uses the print harness `TapHarness.printHarness`.
  ///
  /// - Parameter harness: The harness, that interprets the output.
  /// - Parameter tests: All tests to be executed.
  public static func with(_ harness: TapsHarness? = nil, tests: [(Taps) -> Void]) -> Taps {
    let taps: Taps
    if let harness = harness {
      taps = Taps(harness: harness)
    } else {
      taps = Taps()
    }

    taps.harness.report(.started)
    for test in tests {
      test(taps)
    }
    taps.testCases.onCompleted()

    return taps
  }

  /// Creates a cold `Observable`, that executes all given `Test`s.
  /// Uses the print harness `TapHarness.printHarness`.
  ///
  /// - Parameter harness: The harness, that interprets the output.
  /// - Parameter tests: All tests to be executed.
  public static func runner(
    with harness: TapsHarness? = nil,
    testing tests: [(Taps) -> Void]
  ) -> Observable<TestCount> {
    return with(harness, tests: tests).runner
  }

  /// Creates a hot `Taps`, that executes all given `Test`s.
  /// All tests will be interrupted on dispose.
  ///
  /// - Parameter harness: The harness, that interprets the output.
  /// - Parameter tests: All tests to be executed.
  public static func start(with harness: TapsHarness? = nil, testing tests: [(Taps) -> Void]) -> Disposable {
    return with(harness, tests: tests).start()
  }

  /// Creates a hot `Taps`, that executes all given `Test`s.
  /// All tests will be executed. Exits with 1 if there were errors.
  /// All tests will be interrupted when `Taps` gets deinitialized.
  ///
  /// - Parameter harness: The harness, that interprets the output.
  /// - Parameter tests: All tests to be executed.
  public static func runMain(with harness: TapsHarness? = nil, testing tests: [(Taps) -> Void]) -> Never {
    with(harness, tests: tests).runMain()
  }

  /// Creates a hot `Taps`, that executes all given `Test`s.
  /// All tests will be interrupted when `Taps` gets deinitialized.
  ///
  /// - Parameter harness: The harness, that interprets the output.
  /// - Parameter tests: All tests to be executed.
  public static func run(with harness: TapsHarness? = nil, testing tests: [(Taps) -> Void]) -> Taps {
    let taps = with(harness, tests: tests)
    taps.run()
    return taps
  }
}
