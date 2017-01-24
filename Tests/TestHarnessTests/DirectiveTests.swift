import XCTest
@testable import TestHarness

class DirectiveTests: XCTestCase {
  func testTodoWithoutMessage() {
    let directive = Directive(kind: .todo, message: nil)
    XCTAssertEqual(directive.kind, Directive.Kind.todo)
    XCTAssertNil(directive.message)
    XCTAssertEqual(directive.description, "TODO")
  }

  func testTodoWithMessage() {
    let directive = Directive(kind: .todo, message: "Hello World")
    XCTAssertEqual(directive.kind, Directive.Kind.todo)
    XCTAssertEqual(directive.message, "Hello World")
    XCTAssertEqual(directive.description, "TODO Hello World")
  }

  func testSkipWithoutMessage() {
    let directive = Directive(kind: .skip, message: nil)
    XCTAssertEqual(directive.kind, Directive.Kind.skip)
    XCTAssertNil(directive.message)
    XCTAssertEqual(directive.description, "SKIP")
  }

  func testSkipWithMessage() {
    let directive = Directive(kind: .skip, message: "Hello World")
    XCTAssertEqual(directive.kind, Directive.Kind.skip)
    XCTAssertEqual(directive.message, "Hello World")
    XCTAssertEqual(directive.description, "SKIP Hello World")
  }
}
