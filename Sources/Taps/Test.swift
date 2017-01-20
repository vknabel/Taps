import RxSwift

/// Provides functions, that create `TestPoint`s.
/// Each `TestPoint` is associated to a `Test`.
public final class Test: OfferingTests {
  /// Observes for all `TestPoint`s.
  /// Each `TestPoint` will be passed to `Taps`.
  public private(set) var report: AnyObserver<TestPoint>
  private var plan: Int

  internal init(report: AnyObserver<TestPoint>, plan: Int?) {
    self.plan = plan ?? 0
    self.report = report

    self.report = plan != nil ? AnyObserver {
      switch $0 {
      case let .next(v):
        self.plan -= 1
        if self.plan < 0 {
          let errorPoint = TestPoint(
            isOk: false,
            message: "more test points emitted than planned",
            source: v.sourceLocation,
            details: [
              "operator": .string("plan"),
              "test": .dictionary([
                "ok": .bool(v.isOk),
                "message": .string(v.message ?? "(no message provided)"),
                "source": .dictionary([
                  "file": .string(v.sourceLocation.file),
                  "line": .int(v.sourceLocation.line),
                  "column": .int(v.sourceLocation.column),
                  "function": .string(v.sourceLocation.function)
                ]),
                "details": .dictionary(v.details ?? [:])
              ])
            ]
          )
          fatalError("more test points emitted than planned: \(errorPoint)")
        } else {
          report.on($0)
        }

        if self.plan == 0 {
          report.on(.completed)
        }
      default:
        report.on($0)
      }
    } : report
  }
}

public extension OfferingTests {
  /// Marks a test as finished.
  /// No `TestPoint` may follow.
  public func end() {
    report.onCompleted()
  }
}
