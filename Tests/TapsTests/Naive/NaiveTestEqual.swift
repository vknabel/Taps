import RxSwift
import TestHarness
@testable import Taps

func describeTestEqual(taps: Taps) {
  taps.rx.mockingTest(
    "test equal when equal succeeds",
    plan: 1,
    against: { $0.equal(1, 1) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test equal when not equal fails",
    plan: 1,
    against: { $0.equal(1, 2) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test curried equal when equal succeeds",
    plan: 1,
    against: { $0.equal(to: 1)(1) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test curried equal when not equal fails",
    plan: 1,
    against: { $0.equal(to: 2)(1) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }
}
