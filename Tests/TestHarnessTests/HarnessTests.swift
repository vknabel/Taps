import XCTest
@testable import TestHarness

public class Harness: XCTestCase {
  public func testCreation() {
    let expectation = self.expectation(description: "Shall pass creation through")
    let harness = TestHarness(handler: { _ in
      expectation.fulfill()
    })
    harness.handler(.version(13))
    waitForExpectations(timeout: 0.01)
  }
}
