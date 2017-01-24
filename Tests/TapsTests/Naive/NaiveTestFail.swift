import RxSwift
import TestHarness
@testable import Taps

func describeTestFail(taps: Taps) {
  taps.rx.mockingTest(
    "fail just emits non passing",
    plan: 1,
    against: { $0.fail() },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }
}
