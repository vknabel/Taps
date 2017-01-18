// Generated using Sourcery 0.5.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// swiftlint:disable

fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatable for classes, protocols, structs

// MARK: - SourceLocation AutoEquatable
/// :nodoc:
extension SourceLocation: Equatable {} 

/// :nodoc:
public func == (lhs: SourceLocation, rhs: SourceLocation) -> Bool {
    guard lhs.file == rhs.file else { return false }
    guard lhs.line == rhs.line else { return false }
    guard lhs.column == rhs.column else { return false }
    guard lhs.function == rhs.function else { return false }
    
    return true
}


// MARK: - TestCount AutoEquatable
/// :nodoc:
extension TestCount: Equatable {} 

/// :nodoc:
public func == (lhs: TestCount, rhs: TestCount) -> Bool {
    guard lhs.passes == rhs.passes else { return false }
    guard lhs.failures == rhs.failures else { return false }
    guard lhs.tests == rhs.tests else { return false }
    
    return true
}


// MARK: - TestPoint AutoEquatable
/// :nodoc:
extension TestPoint: Equatable {} 

/// :nodoc:
public func == (lhs: TestPoint, rhs: TestPoint) -> Bool {
    guard lhs.isOk == rhs.isOk else { return false }
    guard compareOptionals(lhs: lhs.message, rhs: rhs.message, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.details, rhs: rhs.details, compare: ==) else { return false }
    guard lhs.sourceLocation == rhs.sourceLocation else { return false }
    
    return true
}



// MARK: - AutoEquatable for Enums


// MARK: -