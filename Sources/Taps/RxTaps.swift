import RxSwift

/// Serves the Rx part of `Taps`.
public final class RxTaps {
  /// The current `Taps` as a back reference. Useful for developing custom test runners.
  public let taps: Taps

  fileprivate init(_ taps: Taps) {
    self.taps = taps
  }
}

public extension Taps {
  /// The Rx API of `Taps`.
  public var rx: RxTaps { // swiftlint:disable:this variable_name
    return RxTaps(self)
  }
}
