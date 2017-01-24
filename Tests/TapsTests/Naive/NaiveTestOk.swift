import RxSwift
import TestHarness
@testable import Taps

func describeTestOk(taps: Taps) {
  taps.rx.mockingTest(
    "test ok for Optional.none fails",
    plan: 1,
    against: { $0.ok(Optional<Int>.none) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test ok for Optional.some succeeds",
    plan: 1,
    against: { $0.ok(Optional<Int>.some(42)) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test ok for false fails",
    plan: 1,
    against: { $0.ok(false) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test ok for true succeeds",
    plan: 1,
    against: { $0.ok(true) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }
  
  taps.rx.mockingTest(
    "test curried ok for Optional.none fails",
    plan: 1,
    against: { $0.ok()(Optional<Int>.none) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }
  
  taps.rx.mockingTest(
    "test curried ok for Optional.some succeeds",
    plan: 1,
    against: { $0.ok()(Optional<Int>.some(42)) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }
  
  taps.rx.mockingTest(
    "test curried ok for false fails",
    plan: 1,
    against: { $0.ok()(false) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }
  
  taps.rx.mockingTest(
    "test curried ok for true succeeds",
    plan: 1,
    against: { $0.ok()(true) },
    timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }
}
