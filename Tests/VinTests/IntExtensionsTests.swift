//
//  IntExtensionsTests.swift
//
//
//  Created by Vincent DeAugustine on 9/24/23.
//

import XCTest

final class IntExtensionsTests: XCTestCase {
    func testWithSuffix() {
        XCTAssertEqual(1.withSuffix, "1st")
        XCTAssertEqual(2.withSuffix, "2nd")
        XCTAssertEqual(3.withSuffix, "3rd")
        XCTAssertEqual(4.withSuffix, "4th")
        XCTAssertEqual(11.withSuffix, "11th")
        XCTAssertEqual(12.withSuffix, "12th")
        XCTAssertEqual(13.withSuffix, "13th")
        XCTAssertEqual(21.withSuffix, "21st")
        XCTAssertEqual(22.withSuffix, "22nd")
        XCTAssertEqual(23.withSuffix, "23rd")
        XCTAssertEqual(24.withSuffix, "24th")
        XCTAssertEqual(25.withSuffix, "25th")
    }

    func testIsMultiple() {
        XCTAssertTrue(12.isMultiple(of: 3))
        XCTAssertTrue(15.isMultiple(of: 5))
        XCTAssertTrue(0.isMultiple(of: 7))
        XCTAssertFalse(10.isMultiple(of: 3))
        XCTAssertFalse(7.isMultiple(of: 2))
    }

    func testMoney() {
        XCTAssertEqual(100.money(), "$100")
        XCTAssertEqual(12_345.money(), "$12,345")
        XCTAssertEqual((-500).money(), "-$500")
        XCTAssertEqual(999_999.money(), "$999,999")
    }

    func testSimpleStr() {
        XCTAssertEqual(12_345.simpleStr(), "12345")
        XCTAssertEqual(1_234_567.simpleStr(useCommas: true), "1,234,567")
        XCTAssertEqual(987_654_321.simpleStr(useCommas: false), "987654321")
        XCTAssertEqual(0.simpleStr(useCommas: true), "0")
    }
}
