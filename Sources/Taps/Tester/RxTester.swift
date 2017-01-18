import RxSwift

public extension Observable {
    public func test(onNext: ((E) throws -> Void)?, onError: ((Error) throws -> Void)?) -> Observable {
        return self.do(
            onNext: onNext,
            onError: onError
        )
    }
}
