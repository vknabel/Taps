import RxSwift

/// Adds the possibility to test `RxSwift.Observable`s.
public extension Observable {
  /// Inspects an observable for running `TestPoint`s.
  ///
  /// - Parameter onNext: A tester for `.onNext` events.
  /// - Parameter onCompleted: A tester for `.onCompleted` events.
  /// - Returns: A semantically equal observable.
  public func test(
    onNext: ((E) throws -> Void)? = nil,
    onCompleted: (() throws -> Void)? = nil
  ) -> Observable {
    return self.do(
      onNext: onNext,
      onCompleted: onCompleted
    )
  }

  /// Inspects an observable for running `TestPoint`s.
  ///
  /// - Parameter onNext: A tester for `.onNext` events.
  /// - Parameter onError: A tester for `.onError` events. Errors won't be catched.
  /// - Parameter onCompleted: A tester for `.onCompleted` events.
  /// - Returns: A semantically equal observable.
  public func test(
    onNext: ((E) throws -> Void)? = nil,
    onError: @escaping (Error) throws -> Void,
    onCompleted: (() throws -> Void)? = nil
  ) -> Observable {
    return self.do(
      onNext: onNext,
      onError: onError,
      onCompleted: onCompleted
    )
    .catchError({ _ in .empty() })
  }
}
