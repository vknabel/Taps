import RxSwift
import TestHarness
@testable import Taps

func describeTestDoesThrow(taps: Taps) {
  taps.rx.mockingTest(
    "test doesThrow(_:test:) on throw",
    plan: 1,
    against: { $0.doesThrow { throw SomeError() } }
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesThrow(_:test:) on return",
    plan: 1,
    against: { $0.doesThrow { return 1 } }
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesThrow(_:_:test:) on throwing some error",
    plan: 1,
    against: { $0.doesThrow(SomeError.self) { throw SomeError() } }
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesThrow(_:_:test:) on throwing another error",
    plan: 1,
    against: { $0.doesThrow(SomeError.self) { throw AnotherError() } }
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesThrow(_:_:test:) on return",
    plan: 1,
    against: { $0.doesThrow(SomeError.self) { return 1 } }
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesThrow(of:_:) on throwing some error",
    plan: 1,
    against: { $0.doesThrow(of: SomeError.self)(SomeError()) }
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesThrow(of:_:) on throwing another error",
    plan: 1,
    against: { $0.doesThrow(of: SomeError.self)(AnotherError()) }
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }
}
