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

// MARK: - Directive AutoHashable
extension Directive: Hashable {
    
    public var hashValue: Int {
        return combineHashes(kind.hashValue, message?.hashValue ?? 0, description.hashValue, 0)
    }
}


// MARK: - AutoHashable for Enums

// MARK: - Directive.Kind AutoHashable
extension Directive.Kind: Hashable {
    public var hashValue: Int {
        switch self {
            
             case .todo: 
                 return combineHashes() 

            
             case .skip: 
                 return combineHashes() 

            
        }
    }
}


// MARK: -
