import RxSwift
import TestHarness
@testable import Taps

func describeTapsSkip(taps: Taps) {
  taps.rx.mockedTestCase(
    "test skip adds skip directive to test case",
    plan: 1,
    against: { $0.skip.test(plan: 1) { _ in } },
    timeout: 0.01
  ) { t, cases in
    return cases.test(
      onNext: t.ok(matches: { $0.directive?.kind == Directive.Kind.skip })
    )
  }

  taps.rx.mockedTestCase(
    "test skip adds skip directive with message to test case",
    plan: 1,
    against: { $0.skip("not done yet").test(plan: 1) { _ in } },
    timeout: 0.01
  ) { t, cases in
    return cases.test(
      onNext: t.ok(matches: { $0.directive?.kind == Directive.Kind.skip })
    )
  }

  taps.rx.mockedTestCase(
    "test todo keeps message",
    plan: 1,
    against: { $0.todo.test(plan: 1) { _ in } },
    timeout: 0.01
  ) { t, cases in
    return cases.test(
      onNext: t.ok(matches: { $0.directive?.message == nil })
    )
  }

  taps.rx.mockedTestCase(
    "test skip adds skip directive with message to test case",
    plan: 1,
    against: { $0.skip("not done yet").test(plan: 1) { _ in } },
    timeout: 0.01
  ) { t, cases in
    return cases.test(
      onNext: t.ok(matches: { $0.directive?.message == "not done yet" })
    )
  }

  taps.rx.mockedTestCase(
    "test skip keeps directive",
    plan: 1,
    against: { $0.skip.todo.test(plan: 1) { _ in } },
    timeout: 0.01
  ) { t, cases in
    return cases.test(
      onNext: t.ok(matches: { $0.directive?.kind == Directive.Kind.todo })
    )
  }

  taps.rx.mockedTestCase(
    "test todo keeps directive with message",
    plan: 1,
    against: { $0.skip("not done yet").todo.test(plan: 1) { _ in } },
    timeout: 0.01
  ) { t, cases in
    return cases.test(
      onNext: t.ok(matches: { $0.directive?.kind == Directive.Kind.todo })
    )
  }
}
