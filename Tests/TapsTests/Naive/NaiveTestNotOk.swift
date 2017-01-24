import RxSwift
import TestHarness
@testable import Taps

func describeTestNotOk(taps: Taps) {
  taps.rx.mockingTest(
    "test not ok for Optional.none succeeds",
    plan: 1,
    against: { $0.notOk(Optional<Int>.none) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test not ok for Optional.some fails",
    plan: 1,
    against: { $0.notOk(Optional<Int>.some(42)) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test not ok for false succeeds",
    plan: 1,
    against: { $0.notOk(false) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test not ok for true fails",
    plan: 1,
    against: { $0.notOk(true) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test curried not ok for Optional.none succeeds",
    plan: 1,
    against: { $0.notOk()(Optional<Int>.none) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test curried not ok for Optional.some fails",
    plan: 1,
    against: { $0.notOk()(Optional<Int>.some(42)) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test curried not ok for false succeeds",
    plan: 1,
    against: { $0.notOk()(false) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test curried not ok for true fails",
    plan: 1,
    against: { $0.notOk()(true) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }
}
