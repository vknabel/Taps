import XCTest
@testable import Taps
@testable import TestHarness

func withoutTests() -> [(Taps) -> Void] {
  return []
}

func emptyTest(_ taps: Taps) -> Void {
  return taps.test("empty test") {
    $0.end()
  }
}

func passingTest(_ taps: Taps) -> Void {
  return taps.test("passing test") {
    $0.pass()
    $0.end()
  }
}

func withOneTest(_ test: @escaping (Taps) -> Void = emptyTest) -> [(Taps) -> Void] {
  return [emptyTest]
}

func withManyTests(_ test: @escaping (Taps) -> Void = emptyTest) -> [(Taps) -> Void] {
  return [emptyTest, passingTest, describeReadmeExamples]
}

public class TapsTests: XCTestCase {
  public func testStartsWithoutTests() {
    let expectation = self.expectation(description: "Starts Taps run")
    _ = Taps.run(
      with: TapsHarness.testHarness { reports in
        XCTAssertNotNil(reports.first)
        XCTAssertEqual(reports.first!, TapsOutput.started, "First report must be .started")
        expectation.fulfill()
      },
      testing: withoutTests()
    )
    waitForExpectations(timeout: 0.1)
  }

  public func testStartsWithOneTest() {
    let expectation = self.expectation(description: "Starts Taps run")
    _ = Taps.run(
      with: .testHarness { reports in
        XCTAssertNotNil(reports.first)
        XCTAssertEqual(reports.first!, TapsOutput.started, "First report must be .started")
        expectation.fulfill()
      },
      testing: withOneTest()
    )
    waitForExpectations(timeout: 0.1)
  }

  public func testStartsWithManyTests() {
    let expectation = self.expectation(description: "Starts Taps run")
    _ = Taps.run(
      with: .testHarness { reports in
        XCTAssertNotNil(reports.first)
        XCTAssertEqual(reports.first!, TapsOutput.started, "First report must be .started")
        expectation.fulfill()
      },
      testing: withManyTests()
    )
    waitForExpectations(timeout: 0.1)
  }

  public func testNaive() {
    do {
      let counts = try Taps.runner(testing: [
        describeTestEnd,
        describeTestDoesNotThrow,
        describeTestDoesThrow,
        describeTestOk,
        describeTestNotOk,
        describeTestEqual,
        describeTestNotEqual,
        describeTestFail,
        describeTestPass,
        describeTapsTodo,
        describeTapsSkip
      ]).toBlocking().single()
      XCTAssertEqual(counts?.failures, 0, "Naive tests have failed")
    } catch {
      XCTFail("Taps.runner.toBlocking.single failed with \(error)")
    }
  }

  public func testReadmeExamplesStart() {
    let expectation = self.expectation(description: "Starts Taps run")
    _ = Taps.run(
      with: .testHarness { reports in
        XCTAssertNotNil(reports.first)
        XCTAssertEqual(reports.first!, TapsOutput.started, "First report must be .started")
        expectation.fulfill()
      },
      testing: [describeReadmeExamples]
    )
    waitForExpectations(timeout: 0.1)
  }

  public func testReadmeExamplesFinish() {
    let expectation = self.expectation(description: "Starts Taps run")
    _ = Taps.run(
      with: .testHarness { reports in
        XCTAssertEqual(reports.count, 10)
        XCTAssertNotNil(reports.last)
        XCTAssertEqual(
          reports.last!,
          TapsOutput.finished(TestCount(passes: 4, failures: 1)),
          "Last report must be .finished"
        )
        expectation.fulfill()
      },
      testing: [describeReadmeExamples]
    )
    waitForExpectations(timeout: 0.1)
  }

  public func testReadmeExamplesFinishOnce() {
    let expectation = self.expectation(description: "Starts Taps run")
    var called = false
    _ = Taps.run(
      with: .testHarness { _ in
        called = !called
        XCTAssertTrue(called, "must only finish once")
        expectation.fulfill()
      },
      testing: [describeReadmeExamples]
    )
    waitForExpectations(timeout: 0.1)
  }

  public func testReadmeExamplesAsynchronous() {
    let expectation = self.expectation(description: "Starts Taps run")
    _ = Taps.run(
      with: .testHarness { reports in
        XCTAssertEqual(reports[1], TapsOutput.testCase("asynchronous test", directive: nil), "Start test")
        if case let .testPoint(testPoint, count: count, directive: directive) = reports[2] {
          XCTAssertEqual(testPoint.message, "pass", "pass test")
          XCTAssertEqual(testPoint.isOk, true, "pass always succeeds")
          XCTAssertEqual(count.tests, 1, "first test")
          XCTAssertEqual(count.passes, 1, "first test passed")
          XCTAssertEqual(count.failures, 0, "none failed")
          XCTAssertNil(directive, "declared without directive")
        } else {
          XCTFail("expected test point as output got: \(reports[2])")
        }
        expectation.fulfill()
      },
      testing: [describeReadmeExamples]
    )
    waitForExpectations(timeout: 200)
  }

  public func testReadmeExamplesSynchronous() {
    let expectation = self.expectation(description: "Starts Taps run")
    _ = Taps.run(
      with: .testHarness { reports in
        XCTAssertEqual(reports[3], TapsOutput.testCase("synchronous test", directive: nil), "Start test")
        if case let .testPoint(testPoint, count: count, directive: directive) = reports[4] {
          XCTAssertEqual(testPoint.message, "are equal", "equal test 1 == 1")
          XCTAssertEqual(testPoint.isOk, true, "equal 1 == 1 succeeds")
          XCTAssertEqual(count.tests, 2, "first test")
          XCTAssertEqual(count.passes, 2, "first test passed")
          XCTAssertEqual(count.failures, 0, "none failed")
          XCTAssertNil(directive, "declared without directive")
        } else {
          XCTFail("expected test point as output")
        }
        expectation.fulfill()
      },
      testing: [describeReadmeExamples]
    )
    waitForExpectations(timeout: 0.1)
  }

  public func testReadmeExamplesReactive() {
    let expectation = self.expectation(description: "Starts Taps run")
    _ = Taps.run(
      with: .testHarness { reports in
        XCTAssertEqual(reports[5], TapsOutput.testCase("reactive test", directive: nil), "Start test")
        if case let .testPoint(testPoint, count: count, directive: directive) = reports[6] {
          XCTAssertEqual(testPoint.message, "should only emit 3", "equal test 3 == 3")
          XCTAssertEqual(testPoint.isOk, true, "equal 3 == 3 succeeds")
          XCTAssertEqual(count.tests, 3, "first test")
          XCTAssertEqual(count.passes, 3, "first test passed")
          XCTAssertEqual(count.failures, 0, "none failed")
          XCTAssertNil(directive, "declared without directive")
        } else {
          XCTFail("expected test point as output")
        }

        if case let .testPoint(testPoint, count: count, directive: directive) = reports[7] {
          XCTAssertEqual(testPoint.message, "should only emit 3", "equal test 3 == 4")
          XCTAssertEqual(testPoint.isOk, false, "equal 3 == 4 fails")
          XCTAssertEqual(count.tests, 4, "first test")
          XCTAssertEqual(count.passes, 3, "first test passed")
          XCTAssertEqual(count.failures, 1, "this failed")
          XCTAssertNil(directive, "declared without directive")
        } else {
          XCTFail("expected test point as output")
        }

        if case let .testPoint(testPoint, count: count, directive: directive) = reports[8] {
          XCTAssertEqual(testPoint.message, "should only emit 3", "equal test 3 == 3")
          XCTAssertEqual(testPoint.isOk, true, "equal 3 == 3 succeeds")
          XCTAssertEqual(count.tests, 5, "first test")
          XCTAssertEqual(count.passes, 4, "first test passed")
          XCTAssertEqual(count.failures, 1, "previous failed")
          XCTAssertNil(directive, "declared without directive")
        } else {
          XCTFail("expected test point as output")
        }
        expectation.fulfill()
      },
      testing: [describeReadmeExamples]
    )
    waitForExpectations(timeout: 0.1)
  }
}
