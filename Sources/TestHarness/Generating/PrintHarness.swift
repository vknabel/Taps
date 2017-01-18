public extension TestHarness {
  public static func printHarness(reporting report: @escaping (String) -> Void = { print($0) }) -> TestHarness {
    return TestHarness { output in
      switch output {
      case let .version(v):
        report("TAP version \(v)")
      case let .plan(expected: count, message: .none):
        report("1..\(count)")
      case let .plan(expected: count, message: .some(message)):
        report("1..\(count) \(message)")
      case let .testPoint(ok: isOk, count: count, message: message, directive: directive, details: details):
        var out = isOk ? "ok" : "not ok"
        if let count = count {
          out += " \(count)"
        }
        if let message = message {
          out += " - \(message)"
        }
        if let directive = directive {
          out += " # \(directive)"
        }
        if let details = details {
          let yamlDescr = details
            .indentedDescription(by: 1)
          out += "\n  ---\n\(yamlDescr)\n  ..."
        }
        report(out)
      case let .diagnostic(message):
        report("# \(message)")
      case let .unknown(message):
        report(message)
      case .bailOut(.none):
        report("Bail out!")
      case let .bailOut(.some(message)):
        report("Bail out! \(message)")
      }
    }
  }
}
