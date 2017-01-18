import RxSwift
@testable import Taps

func describeTaps(t: Taps) {
  t.test("taps reports started", timeout: 0.01) { t in
    // let started = ReplaySubject<>()

    t.end()
  }

  t.rx.test("reactive test") { t in
    return Observable.of(1, 2)
      .map({ t.equal($0, 1) })
  }
}
