import XCTest
@testable import TestHarness

public class DirectiveTests: XCTestCase {
  public func testTodoWithoutMessage() {
    let directive = Directive(kind: .todo, message: nil)
    XCTAssertEqual(directive.kind, Directive.Kind.todo)
    XCTAssertNil(directive.message)
    XCTAssertEqual(directive.description, "TODO")
  }

  public func testTodoWithMessage() {
    let directive = Directive(kind: .todo, message: "Hello World")
    XCTAssertEqual(directive.kind, Directive.Kind.todo)
    XCTAssertEqual(directive.message, "Hello World")
    XCTAssertEqual(directive.description, "TODO Hello World")
  }

  public func testSkipWithoutMessage() {
    let directive = Directive(kind: .skip, message: nil)
    XCTAssertEqual(directive.kind, Directive.Kind.skip)
    XCTAssertNil(directive.message)
    XCTAssertEqual(directive.description, "SKIP")
  }

  public func testSkipWithMessage() {
    let directive = Directive(kind: .skip, message: "Hello World")
    XCTAssertEqual(directive.kind, Directive.Kind.skip)
    XCTAssertEqual(directive.message, "Hello World")
    XCTAssertEqual(directive.description, "SKIP Hello World")
  }
}
