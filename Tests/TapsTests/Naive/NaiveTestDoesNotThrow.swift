import RxSwift
import TestHarness
@testable import Taps

func describeTestDoesNotThrow(taps: Taps) {
  taps.rx.mockingTest(
    "test doesNotThrow(_:test:) on throw",
    plan: 1,
    against: { $0.doesNotThrow { throw SomeError() } }
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesNotThrow(_:test:) on return",
    plan: 1,
    against: { $0.doesNotThrow { return 1 } }
  ) { t, points in
    points.test(
      onNext: t.ok(with: "doesNotThrow emits ok test point", matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesNotThrow(_:_:test:) on throwing some error",
    plan: 1,
    against: { $0.doesNotThrow(SomeError.self) { throw SomeError() } }
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesNotThrow(_:_:test:) on throwing another error",
    plan: 1,
    against: { $0.doesNotThrow(SomeError.self) { throw AnotherError() } }
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesNotThrow(_:_:test:) on return",
    plan: 1,
    against: { $0.doesNotThrow(SomeError.self) { return 1 } }
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesNotThrow(of:_:) on throwing some error",
    plan: 1,
    against: { $0.doesNotThrow(of: SomeError.self)(SomeError()) }
  ) { t, points in
    points.test(
      onNext: t.notOk(matches: TestPoint.isOk)
    )
  }

  taps.rx.mockingTest(
    "test doesNotThrow(of:_:) on throwing another error",
    plan: 1,
    against: { $0.doesNotThrow(of: SomeError.self)(AnotherError()) }
  ) { t, points in
    points.test(
      onNext: t.ok(matches: TestPoint.isOk)
    )
  }
}
