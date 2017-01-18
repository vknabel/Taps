public struct SourceLocation: AutoEquatable, AutoHashable {
  let file: String
  let line: Int
  let column: Int
  let function: String
}
