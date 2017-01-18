// Generated using Sourcery 0.5.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// swiftlint:disable trailing_comma vertical_whitespace trailing_comma leading_whitespace trailing_newline line_length opening_brace

import XCTest
import TestHarnessTests
import TapsTests

extension Harness {
  static var allTests = [
    ("testCreation", testCreation),
  ]
}

extension TapsTests {
  static var allTests = [
    ("testStartsWithoutTests", testStartsWithoutTests),
    ("testStartsWithOneTest", testStartsWithOneTest),
    ("testStartsWithManyTests", testStartsWithManyTests),
    ("testNaive", testNaive),
    ("testReadmeExamplesStart", testReadmeExamplesStart),
    ("testReadmeExamplesFinish", testReadmeExamplesFinish),
    ("testReadmeExamplesFinishOnce", testReadmeExamplesFinishOnce),
    ("testReadmeExamplesAsynchronous", testReadmeExamplesAsynchronous),
    ("testReadmeExamplesSynchronous", testReadmeExamplesSynchronous),
    ("testReadmeExamplesReactive", testReadmeExamplesReactive),
  ]
}

extension YamlTests {
  static var allTests = [
    ("testNullDescription", testNullDescription),
    ("testTruthyBoolDescription", testTruthyBoolDescription),
    ("testFalsyBoolDescription", testFalsyBoolDescription),
    ("testZeroIntDescription", testZeroIntDescription),
    ("testPositiveIntDescription", testPositiveIntDescription),
    ("testNegativeIntDescription", testNegativeIntDescription),
    ("testZeroDoubleDescription", testZeroDoubleDescription),
    ("testEvenDoubleDescription", testEvenDoubleDescription),
    ("testPositiveDoubleDescription", testPositiveDoubleDescription),
    ("testNegativeDoubleDescription", testNegativeDoubleDescription),
    ("testEmptyDescription", testEmptyDescription),
    ("testHarmlessStringDescription", testHarmlessStringDescription),
    ("testStringWithColonDescription", testStringWithColonDescription),
    ("testStringWithQuoteDescription", testStringWithQuoteDescription),
    ("testStringWithNewlineDescription", testStringWithNewlineDescription),
    ("testStringWithStartingBraceDescription", testStringWithStartingBraceDescription),
    ("testStringWithInnerBraceDescription", testStringWithInnerBraceDescription),
    ("testStringWithStartingBracketDescription", testStringWithStartingBracketDescription),
    ("testStringWithInnerBracketDescription", testStringWithInnerBracketDescription),
    ("testEmptyArrayDescription", testEmptyArrayDescription),
    ("testFlatArrayDescription", testFlatArrayDescription),
    ("testDeepArrayDescription", testDeepArrayDescription),
    ("testComplexArrayDescription", testComplexArrayDescription),
    ("testEmptyDictionaryDescription", testEmptyDictionaryDescription),
    ("testFlatDictionaryDescription", testFlatDictionaryDescription),
    ("testDeepDictionaryDescription", testDeepDictionaryDescription),
    ("testComplexDictionaryDescription", testComplexDictionaryDescription),
    ("testEquatableForNull", testEquatableForNull),
    ("testEquatableForBool", testEquatableForBool),
    ("testEquatableForInt", testEquatableForInt),
    ("testEquatableForDouble", testEquatableForDouble),
    ("testEquatableForString", testEquatableForString),
    ("testEquatableForArray", testEquatableForArray),
    ("testEquatableForDictionary", testEquatableForDictionary),
    ("testEquatableForDifferent", testEquatableForDifferent),
  ]
}


XCTMain([
  testCase(Harness.allTests),
  testCase(TapsTests.allTests),
  testCase(YamlTests.allTests),
])
