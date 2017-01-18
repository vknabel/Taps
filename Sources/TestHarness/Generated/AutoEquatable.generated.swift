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

// MARK: - Directive AutoEquatable
/// :nodoc:
extension Directive: Equatable {} 

/// :nodoc:
public func == (lhs: Directive, rhs: Directive) -> Bool {
    guard lhs.kind == rhs.kind else { return false }
    guard compareOptionals(lhs: lhs.message, rhs: rhs.message, compare: ==) else { return false }
    guard lhs.description == rhs.description else { return false }
    
    return true
}





// MARK: - AutoEquatable for Enums

// MARK: - Directive.Kind AutoEquatable
/// :nodoc:
extension Directive.Kind: Equatable {}
/// :nodoc:
public func == (lhs: Directive.Kind, rhs: Directive.Kind) -> Bool {
    switch (lhs, rhs) {
        
         case (.todo, .todo): 
             return true 

        
         case (.skip, .skip): 
             return true 

        
        default: return false
    }
}

// MARK: - TestOutput AutoEquatable
/// :nodoc:
extension TestOutput: Equatable {}
/// :nodoc:
public func == (lhs: TestOutput, rhs: TestOutput) -> Bool {
    switch (lhs, rhs) {
        
         case (.version(let lhs), .version(let rhs)): 
            
                
                    return lhs == rhs
                
            

        
         case (.plan(let lhs), .plan(let rhs)): 
            
                
                     if lhs.expected != rhs.expected { return false }
                     if lhs.message != rhs.message { return false }
                     return true
                    
            

        
         case (.testPoint(let lhs), .testPoint(let rhs)): 
            
                
                     if lhs.ok != rhs.ok { return false }
                     if lhs.count != rhs.count { return false }
                     if lhs.message != rhs.message { return false }
                     if lhs.directive != rhs.directive { return false }
                     if lhs.details != rhs.details { return false }
                     return true
                    
            

        
         case (.diagnostic(let lhs), .diagnostic(let rhs)): 
            
                
                    return lhs == rhs
                
            

        
         case (.unknown(let lhs), .unknown(let rhs)): 
            
                
                    return lhs == rhs
                
            

        
         case (.bailOut(let lhs), .bailOut(let rhs)): 
            
                
                    return lhs == rhs
                
            

        
        default: return false
    }
}


// MARK: -