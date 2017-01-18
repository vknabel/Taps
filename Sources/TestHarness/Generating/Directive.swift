public struct Directive: AutoHashable, AutoEquatable, CustomStringConvertible {
  public let kind: Kind
  public let message: String?

  public init(kind: Kind, message: String?) {
    self.kind = kind
    self.message = message
  }

  public enum Kind: AutoHashable, AutoEquatable, CustomStringConvertible {
    case todo
    case skip

    public var description: String {
      switch self {
      case .todo:
        return "TODO"
      case .skip:
        return "SKIP"
      }
    }
  }

  public var description: String {
    if let message = message {
      return "\(kind) \(message)"
    } else {
      return kind.description
    }
  }
}
