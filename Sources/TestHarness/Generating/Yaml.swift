import Foundation

public enum Yaml: Equatable, CustomStringConvertible {
  case null
  case bool(Bool)
  case int(Int)
  case double(Double)
  case string(String)
  case array([Yaml])
  case dictionary([String: Yaml])

  public func indentedDescription(by level: Int, inlined isInlined: Bool = false) -> String {
    let blockIndent = String(repeating: "  ", count: level)
    let inlineIndent = isInlined ? "" : blockIndent
    switch self {
    case .null:
      return inlineIndent + "null"
    case let .bool(v):
      return inlineIndent + "\(v)"
    case let .int(v):
      return inlineIndent + "\(v)"
    case let .double(v):
      return inlineIndent + "\(v)"
    case let .string(v)
      where !v.isEmpty
        && !v.contains(":")
        && !v.contains("\"")
        && !v.contains("\n")
        && !v.hasPrefix("{")
        && !v.hasPrefix("[")
        && !v.hasPrefix("{"):
      return inlineIndent + v
    case let .string(v):
      let escaped = v.replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "\"", with: "\\\"")
      return inlineIndent + "\"\(escaped)\""
    case let .array(v) where v.isEmpty:
      return inlineIndent + "[]"
    case let .array(v):
      return (isInlined ? "\n" : "") + v.map {
        ("\(blockIndent)- ") + $0.indentedDescription(by: level + 1, inlined: true)
      }.joined(separator: "\n")
    case let .dictionary(v) where v.isEmpty:
      return inlineIndent + "{}"
    case let .dictionary(v):
      return (isInlined ? "\n" : "") + v.map {
        ("\(blockIndent)\($0.0): ") + $0.1.indentedDescription(by: level + 1, inlined: true)
      }.joined(separator: "\n")
    }
  }

  public var description: String {
    return indentedDescription(by: 0)
  }

  public static func == (lhs: Yaml, rhs: Yaml) -> Bool {
    switch (lhs, rhs) {
    case (.null, .null):
      return true
    case let (.bool(l0), .bool(r0)):
      return l0 == r0
    case let (.int(l0), .int(r0)):
      return l0 == r0
    case let (.double(l0), .double(r0)):
      return l0 == r0
    case let (.string(l0), .string(r0)):
      return l0 == r0
    case let (.array(l0), .array(r0)):
      return l0 == r0
    case let (.dictionary(l0), .dictionary(r0)):
      return l0 == r0
    default:
      return false
    }
  }
}
