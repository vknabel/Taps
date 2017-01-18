import RxSwift

public final class Test {
    public private(set) var report: AnyObserver<TestPoint>
    public private(set) var plan: Int

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
struct PointError: Error {
  let point: TestPoint
}
public  extension Test {
  public func end() {
    report.onCompleted()
  }
}
