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

/// Static attributes will operate on Taps itself
/// All other are for testing purposes
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

  public init(harness: TapsHarness? = nil) {
    self.harness = harness ?? .printHarness
  }

  private var runner: Observable<TestCount> {
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

  public func start() -> Disposable {
    return runner.subscribe()
  }

  public func run() {
    return start().addDisposableTo(testBag)
  }

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

  public static func start(tests: [(Taps) -> Void]) -> Disposable {
    let taps = Taps()

    taps.harness.report(.started)
    for test in tests {
      test(taps)
    }
    taps.testCases.onCompleted()

    return taps.start()
  }

  public static func start(with harness: TapsHarness, tests: [(Taps) -> Void]) -> Disposable {
    let taps = Taps(harness: harness)

    taps.harness.report(.started)
    for test in tests {
      test(taps)
    }
    taps.testCases.onCompleted()

    return taps.start()
  }

  public static func run(tests: [(Taps) -> Void]) -> Taps {
    let taps = Taps()

    taps.harness.report(.started)
    for test in tests {
      test(taps)
    }
    taps.testCases.onCompleted()

    taps.run()
    return taps
  }

  public static func run(with harness: TapsHarness, tests: [(Taps) -> Void]) -> Taps {
    let taps = Taps(harness: harness)

    taps.harness.report(.started)
    for test in tests {
      test(taps)
    }
    taps.testCases.onCompleted()

    taps.run()
    return taps
  }

  public static func runMain(tests: [(Taps) -> Void]) -> Never {
    let taps = Taps()

    taps.harness.report(.started)
    for test in tests {
      test(taps)
    }
    taps.testCases.onCompleted()

    taps.runMain()
  }

  public static func runMain(with harness: TapsHarness, tests: [(Taps) -> Void]) -> Never {
    let taps = Taps(harness: harness)

    taps.harness.report(.started)
    for test in tests {
      test(taps)
    }
    taps.testCases.onCompleted()

    taps.runMain()
  }
}
