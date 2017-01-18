import RxSwift

public final class RxTaps {
    public let taps: Taps

    fileprivate init(_ taps: Taps) {
        self.taps = taps
    }
}

public extension Taps {
    public var rx: RxTaps { // swiftlint:disable:this variable_name
        return RxTaps(self)
    }
}
