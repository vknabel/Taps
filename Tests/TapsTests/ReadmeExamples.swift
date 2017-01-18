import RxSwift
@testable import Taps
import Dispatch

fileprivate func async(_ call: @escaping () -> Void) {
  DispatchQueue.global().async {
    call() // Todo: Really async operation
  }
}

fileprivate func someInt() -> Int {
    return 1
}

fileprivate struct MyService {
    func someObservable() -> Observable<Int> {
        return Observable.of(3, 4, 3)
    }
}

func describeReadmeExamples(t: Taps) {
  t.test("asynchronous test") { t in
    async {
      t.pass()
      t.end()
    }
  }

  t.test("synchronous test", plan: 1) { t in
    t.equal(someInt(), 1)
  }

  t.rx.test("reactive test") { (t: Test) -> Observable<Int> in
    let myService = MyService()
    return myService.someObservable()
      .test(
        onNext: t.equal(to: 3, "should only emit 3"),
        onError: t.fail("should not throw")
      )
  }
}
