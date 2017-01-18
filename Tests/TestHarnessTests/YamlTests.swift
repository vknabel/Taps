import XCTest
@testable import TestHarness

public class YamlTests: XCTestCase {
    // MARK: - Description Tests

    // MARK: .null description
    public func testNullDescription() {
        let yaml = Yaml.null
        let description = yaml.description
        XCTAssertEqual(description, "null", "null description")
    }

    // MARK: .bool(_) description
    public func testTruthyBoolDescription() {
        let yaml = Yaml.bool(true)
        let description = yaml.description
        XCTAssertEqual(description, "true", "true as is")
    }
    public func testFalsyBoolDescription() {
        let yaml = Yaml.bool(false)
        let description = yaml.description
        XCTAssertEqual(description, "false", "false as is")
    }

    // MARK: .int(_) description
    public func testZeroIntDescription() {
        let yaml = Yaml.int(0)
        let description = yaml.description
        XCTAssertEqual(description, "0", "zero as 0")
    }
    public func testPositiveIntDescription() {
        let yaml = Yaml.int(3)
        let description = yaml.description
        XCTAssertEqual(description, "3", "positive ints as is")
    }
    public func testNegativeIntDescription() {
        let yaml = Yaml.int(-3)
        let description = yaml.description
        XCTAssertEqual(description, "-3", "negative ints as is")
    }

    // MARK: .double(_) description
    public func testZeroDoubleDescription() {
        let yaml = Yaml.double(0.0)
        let description = yaml.description
        XCTAssertEqual(description, "0.0", "no abbreviation for zero doubles")
    }
    public func testEvenDoubleDescription() {
        let yaml = Yaml.double(1.0)
        let description = yaml.description
        XCTAssertEqual(description, "1.0", "even doubles print .0")
    }
    public func testPositiveDoubleDescription() {
        let yaml = Yaml.double(1.3)
        let description = yaml.description
        XCTAssertEqual(description, "1.3", "all digits of double")
    }
    public func testNegativeDoubleDescription() {
        let yaml = Yaml.double(-0.4)
        let description = yaml.description
        XCTAssertEqual(description, "-0.4", "negative double with -")
    }

    // MARK: .string(_) description
    public func testEmptyDescription() {
        let yaml = Yaml.string("")
        let description = yaml.description
        XCTAssertEqual(description, "\"\"", "empty string have quotes")
    }
    public func testHarmlessStringDescription() {
        let yaml = Yaml.string("Hello World!")
        let description = yaml.description
        XCTAssertEqual(description, "Hello World!", "harmless strings have no quotes")
    }
    public func testStringWithColonDescription() {
        let yaml = Yaml.string("Hello: World!")
        let description = yaml.description
        XCTAssertEqual(description, "\"Hello: World!\"", "harmful strings have quotes")
    }
    public func testStringWithQuoteDescription() {
        let yaml = Yaml.string("Hello\" World!")
        let description = yaml.description
        XCTAssertEqual(description, "\"Hello\\\" World!\"", "harmful strings have quotes")
    }
    public func testStringWithNewlineDescription() {
        let yaml = Yaml.string("Hello\n World!")
        let description = yaml.description
        XCTAssertEqual(description, "\"Hello\n World!\"", "harmful strings have quotes")
    }
    public func testStringWithStartingBraceDescription() {
        let yaml = Yaml.string("{Hello World!")
        let description = yaml.description
        XCTAssertEqual(description, "\"{Hello World!\"", "harmful strings have quotes")
    }
    public func testStringWithInnerBraceDescription() {
        let yaml = Yaml.string("Hello{} World!")
        let description = yaml.description
        XCTAssertEqual(description, "Hello{} World!", "inner braces are harmless")
    }
    public func testStringWithStartingBracketDescription() {
        let yaml = Yaml.string("[Hello World!")
        let description = yaml.description
        XCTAssertEqual(description, "\"[Hello World!\"", "harmful strings have quotes")
    }
    public func testStringWithInnerBracketDescription() {
        let yaml = Yaml.string("Hello[] World!")
        let description = yaml.description
        XCTAssertEqual(description, "Hello[] World!", "inner brackets are harmless")
    }

    // MARK: .array(_) description
    public func testEmptyArrayDescription() {
        let yaml = Yaml.array([])
        let description = yaml.description
        XCTAssertEqual(description, "[]", "empty array")
    }
    public func testFlatArrayDescription() {
        let yaml = Yaml.array([.string("Hello World!"), .int(42)])
        let description = yaml.description
        XCTAssertEqual(description, "- Hello World!\n- 42", "array on multiple lines")
    }
    public func testDeepArrayDescription() {
        let yaml = Yaml.array([.array([.int(2)]), .null])
        let description = yaml.description
        XCTAssertEqual(description, "- \n  - 2\n- null", "Must nest indents")
    }
    public func testComplexArrayDescription() {
        let yaml = Yaml.array([.array([.int(2), .dictionary(["array": .array([.null])])]), .null])
        let description = yaml.description
        XCTAssertEqual(description, "- \n"
                                  + "  - 2\n"
                                  + "  - \n"
                                  + "    array: \n"
                                  + "      - null\n"
                                  + "- null",
            "must indent complex arrays right"
        )
    }

    // MARK: .dictionary(_) description
    public func testEmptyDictionaryDescription() {
        let yaml = Yaml.dictionary([:])
        let description = yaml.description
        XCTAssertEqual(description, "{}", "empty dicts are {}")
    }
    public func testFlatDictionaryDescription() {
        let yaml = Yaml.dictionary(["name": .string("vknabel"), "number": .double(3.0)])
        let description = yaml.description
        XCTAssertEqual(description, "name: vknabel\nnumber: 3.0", "flat dictionaries shall not be intended")
    }
    public func testDeepDictionaryDescription() {
        let yaml = Yaml.dictionary(["dict": .dictionary(["x": .string("Hi")]), "name": .null])
        let description = yaml.description
        XCTAssertEqual(description, "dict: \n  x: Hi\nname: null", "deeper dictionaries shall indent right")
    }
    public func testComplexDictionaryDescription() {
        let yaml = Yaml.dictionary([
            "array": .array([
                .dictionary(["x": .string("Hi")]),
                .string("text:")
            ])
        ])
        let description = yaml.description
        let expected = "array: \n"
                     + "  - \n"
                     + "    x: Hi\n"
                     + "  - \"text:\""
        XCTAssertEqual(description, expected, "complex dictionaries shall fit")
    }

    // MARK: - Equatable
    public func testEquatableForNull() {
        XCTAssertTrue(Yaml.null == .null, "nulls are equal")
    }
    public func testEquatableForBool() {
        XCTAssertTrue(Yaml.bool(true) == .bool(true), "same bools are equal")
        XCTAssertTrue(Yaml.bool(false) == .bool(false), "same bools are equal")
        XCTAssertFalse(Yaml.bool(true) == .bool(false), "different bools are not equal")
        XCTAssertFalse(Yaml.bool(false) == .bool(true), "different bools are not equal")
    }
    public func testEquatableForInt() {
        XCTAssertTrue(Yaml.int(0) == .int(0), "same ints are equal")
        XCTAssertTrue(Yaml.int(2) == .int(2), "same ints are equal")
        XCTAssertTrue(Yaml.int(-1) == .int(-1), "same ints are equal")

        XCTAssertFalse(Yaml.int(0) == .int(1), "different ints are not equal")
        XCTAssertFalse(Yaml.int(1) == .int(0), "different ints are not equal")
        XCTAssertFalse(Yaml.int(-1) == .int(1), "different ints are not equal")
    }
    public func testEquatableForDouble() {
        XCTAssertTrue(Yaml.double(0) == .double(0), "same doubles are equal")
        XCTAssertTrue(Yaml.double(2.1) == .double(2.1), "same doubles are equal")
        XCTAssertTrue(Yaml.double(-1.3) == .double(-1.3), "same doubles are equal")

        XCTAssertFalse(Yaml.double(0) == .double(0.1), "different doubles are not equal")
        XCTAssertFalse(Yaml.double(1) == .double(0), "different doubles are not equal")
        XCTAssertFalse(Yaml.double(-1) == .double(1), "different doubles are not equal")
    }
    public func testEquatableForString() {
        XCTAssertTrue(Yaml.string("Hello") == .string("Hello"), "same strings are equal")
        XCTAssertTrue(Yaml.string("World") == .string("World"), "same strings are equal")
        XCTAssertTrue(Yaml.string("[{\\\n\":") == .string("[{\\\n\":"), "same strings are equal")

        XCTAssertFalse(Yaml.string("[{\\\n\":") == .string("Hello"), "different strings are not equal")
        XCTAssertFalse(Yaml.string("") == .string("X"), "different strings are not equal")
        XCTAssertFalse(Yaml.string("World") == .string("[{\\\n\":"), "different strings are not equal")
    }
    public func testEquatableForArray() {
        XCTAssertTrue(Yaml.array([]) == .array([]), "same arrays are equal")
        XCTAssertTrue(Yaml.array([.null]) == .array([.null]), "same arrays are equal")
        XCTAssertTrue(Yaml.array([.array([])]) == .array([.array([])]), "same arrays are equal")

        XCTAssertFalse(Yaml.array([.array([])]) == .array([]), "different arrays are not equal")
        XCTAssertFalse(Yaml.array([.null]) == .array([]), "different arrays are not equal")
        XCTAssertFalse(Yaml.array([.null, .dictionary([:])]) == .array([.array([])]), "different arrays not equal")
    }
    public func testEquatableForDictionary() {
        XCTAssertTrue(Yaml.dictionary([:]) == .dictionary([:]), "same dictionaries are equal")
        XCTAssertTrue(Yaml.dictionary(["x": .null]) == .dictionary(["x": .null]), "same dictionaries are equal")
        XCTAssertTrue(
            Yaml.dictionary(["array": .array([])])
                == .dictionary(["array": .array([])]),
            "same dictionaries are equal"
        )

        XCTAssertFalse(
            Yaml.dictionary(["array": .array([])])
                == Yaml.dictionary(["other": .array([])]),
            "different dictionaries are not equal"
        )
        XCTAssertFalse(Yaml.dictionary(["x": .null]) == .dictionary([:]), "different dictionaries are not equal")
        XCTAssertFalse(
            Yaml.dictionary(["x": .null])
                == .dictionary(["x": .array([])]),
            "different dictionaries are not equal"
        )
    }
    public func testEquatableForDifferent() {
        // null
        XCTAssertFalse(Yaml.null == .bool(false), "different cases are not equal")
        XCTAssertFalse(Yaml.null == .int(0), "different cases are not equal")
        XCTAssertFalse(Yaml.null == .double(1.3), "different cases are not equal")
        XCTAssertFalse(Yaml.null == .string("null"), "different cases are not equal")
        XCTAssertFalse(Yaml.null == .array([]), "different cases are not equal")
        XCTAssertFalse(Yaml.null == .dictionary([:]), "different cases are not equal")

        // bool
        XCTAssertFalse(Yaml.bool(false) == .int(0), "different cases are not equal")
        XCTAssertFalse(Yaml.bool(true) == .double(1.3), "different cases are not equal")
        XCTAssertFalse(Yaml.bool(false) == .string("null"), "different cases are not equal")
        XCTAssertFalse(Yaml.bool(true) == .array([]), "different cases are not equal")
        XCTAssertFalse(Yaml.bool(false) == .dictionary([:]), "different cases are not equal")

        // int
        XCTAssertFalse(Yaml.int(1) == .double(1.0), "different cases are not equal")
        XCTAssertFalse(Yaml.int(2) == .string("2"), "different cases are not equal")
        XCTAssertFalse(Yaml.int(3) == .array([]), "different cases are not equal")
        XCTAssertFalse(Yaml.int(-1) == .dictionary([:]), "different cases are not equal")

        // double
        XCTAssertFalse(Yaml.double(2.0) == .string("2.0"), "different cases are not equal")
        XCTAssertFalse(Yaml.double(0.0) == .array([]), "different cases are not equal")
        XCTAssertFalse(Yaml.double(-1) == .dictionary([:]), "different cases are not equal")

        // double
        XCTAssertFalse(Yaml.string("[]") == .array([]), "different cases are not equal")
        XCTAssertFalse(Yaml.string("{}") == .dictionary([:]), "different cases are not equal")

        // double
        XCTAssertFalse(Yaml.array([]) == .dictionary([:]), "different cases are not equal")
    }
}
