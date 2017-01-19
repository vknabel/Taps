import RxSwift
import TestHarness
@testable import Taps

func describeTestEnd(taps: Taps) {
  taps.rx.mockingTest(
    "test end completes",
    against: { $0.end() }, timeout: 0.01
  ) { t, points in
    points.test(
      onNext: t.fail(with: "end doesn't emit"),
      onError: t.fail(with: "end doesn't fail"),
      onCompleted: t.pass(with: "end completes")
    )
  }
}
