import RxSwift
import TestHarness
@testable import Taps

func describeTestPass(taps: Taps) {
  taps.rx.mockingTest(
    "pass emits passing",
    plan: 1,
    against: { $0.pass() },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }
}
