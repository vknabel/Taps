import RxSwift
import TestHarness
@testable import Taps

func describeTestNotEqual(taps: Taps) {
  taps.rx.mockingTest(
    "test non equal when equal fails",
    plan: 1,
    against: { $0.notEqual(1, 1) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test non equal when not equal succeeds",
    plan: 1,
    against: { $0.notEqual(1, 2) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test curried non equal when equal fails",
    plan: 1,
    against: { $0.notEqual(to: 1)(1) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test curried non equal when not equal succeeds",
    plan: 1,
    against: { $0.notEqual(to: 2)(1) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }
}
