import RxSwift

/// Adds the possibility to test `RxSwift.Observable`s.
public extension Observable {
  /// Inspects an observable for running `TestPoint`s.
  ///
  /// - Parameter onNext: A tester for `.onNext` events.
  /// - Parameter onError: A tester for `.onError` events. Errors won't be catched.
  /// - Returns: A semantically equal observable.
  public func test(onNext: ((E) throws -> Void)?, onError: ((Error) throws -> Void)?) -> Observable {
    return self.do(
      onNext: onNext,
      onError: onError
    )
  }
}
