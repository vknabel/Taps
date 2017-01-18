// Generated using Sourcery 0.5.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// swiftlint:disable

fileprivate func combineHashes(_ hashes: Int...) -> Int {
    var combinedHash = 5381

    for itemHash in hashes {
        combinedHash = ((combinedHash << 5) &+ combinedHash) &+ itemHash
    }

    return combinedHash
}

// MARK: - AutoHashable for classes, protocols, structs

// MARK: - SourceLocation AutoHashable
/// :nodoc:
extension SourceLocation: Hashable {
    
    /// :nodoc:
    public var hashValue: Int {
        return combineHashes(file.hashValue, line.hashValue, column.hashValue, function.hashValue, 0)
    }
}


// MARK: - AutoHashable for Enums


// MARK: -
