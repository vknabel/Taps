import Taps

extension TapsHarness {
  /// Validator will be called on each emitted summary
  static func testHarness(with validator: @escaping ([TapsOutput]) -> Void) -> TapsHarness {
    var currentReports = [TapsOutput]()
    return TapsHarness { data in
      currentReports.append(data)
      if case .finished(_) = data {
        validator(currentReports)
      }
    }
  }
}
