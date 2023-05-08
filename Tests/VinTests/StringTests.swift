//
//  StringTests.swift
//
//
//  Created by Vincent DeAugustine on 5/8/23.
//

import XCTest

final class StringTests: XCTestCase {
    func testPrefixStr() throws {
        let string = "Hello, world!"

        XCTAssertEqual(string.prefixStr(0), "")
        XCTAssertEqual(string.prefixStr(-1), "")
        XCTAssertEqual(string.prefixStr(5), "Hello")
        XCTAssertEqual(string.prefixStr(20), "Hello, world!")
        XCTAssertEqual(string.prefixStr(13), "Hello, world!")
    }

    func testSuffixStr() {
        let string = "Hello, world!"

        XCTAssertEqual(string.suffixStr(0), "")
        XCTAssertEqual(string.suffixStr(-1), "")
        XCTAssertEqual(string.suffixStr(6), "world!")
        XCTAssertEqual(string.suffixStr(20), "Hello, world!")
        XCTAssertEqual(string.suffixStr(13), "Hello, world!")
        XCTAssertEqual(string.suffixStr(string.count - 2), "llo, world!")
    }
}
