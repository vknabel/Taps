import RxSwift

/// Serves the Rx part of `Taps`.
public final class RxTaps: OfferingRxTaps {
  /// The current `Taps` as a back reference. Useful for developing custom test runners.
  private let taps: OfferingTaps
  public var testCaseObserver: AnyObserver<TestCase> {
    return taps.testCaseObserver
  }

  fileprivate init(_ taps: OfferingTaps) {
    self.taps = taps
  }
}

public extension OfferingTaps {
  /// The Rx API of `Taps`.
  public var rx: RxTaps { // swiftlint:disable:this variable_name
    return RxTaps(self)
  }
}
