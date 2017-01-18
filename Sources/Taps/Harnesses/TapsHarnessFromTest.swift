import TestHarness

public extension TapsHarness {
  /// Converts a `TestHarness` into a `TapsHarness`.
  ///
  /// - Parameter harness: A `TestHarness` shall support the `TapsOutput`.
  public static func tapsHarnessFrom(test harness: TestHarness) -> TapsHarness {
    let report = harness.handler
    return TapsHarness { data in
      switch data {
      case .started:
        report(TestOutput.version(13))
      case let .testCase(title, directive: .none):
        report(.diagnostic(title))
      case let .testCase(title, directive: .some(d)):
        report(.diagnostic("\(title) # \(d)"))
      case let .testPoint(point, count: count, directive: directive):
        report(.testPoint(
          ok: point.isOk,
          count: count.tests,
          message: point.message,
          directive: directive,
          details: point.details != nil ? .dictionary(point.details!) : nil
        ))
        if !point.isOk {
          let file = "\(point.sourceLocation.file):\(point.sourceLocation.line):\(point.sourceLocation.column)"
          let directiveText: String
          if let directive = directive {
            directiveText = "# \(directive)"
          } else {
            directiveText = ""
          }
          report(
            .unknown("\(file): error: \(point.sourceLocation.function) : not ok \(count.tests)"
              + (point.message ?? "") + directiveText)
          )
        }
      case let .finished(count):
        report(.plan(expected: count.tests, message: nil))
        report(.diagnostic("tests \(count.tests)"))
        report(.diagnostic("pass \(count.passes)"))
        report(.diagnostic("fail \(count.failures)"))
      case let .bailOut(reason):
        report(.bailOut(reason))
      }
    }
  }
}
