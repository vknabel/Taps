import TestHarness

public extension TapsHarness {
  /// A `TapsHarness`, that prints out all `TapOutput` as TAP13.
  public static var printHarness = tapsHarnessFrom(test: .printHarness())
}
