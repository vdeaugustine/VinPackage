//
//  DoubleTests.swift
//
//
//  Created by Vincent DeAugustine on 5/11/23.
//

import Vin
import XCTest

final class DoubleTests: XCTestCase {
    func testPositiveDollarAmount() {
        let result = 1_234.56.money()
        XCTAssertEqual(result, "$1,234.56")
    }

    func testNegativeDollarAmount() {
        let result = (-1_234.56).money()
        XCTAssertEqual(result, "-$1,234.56")
    }

    func testZeroDollarAmount() {
        let result = 0.00.money()
        XCTAssertEqual(result, "$0")
    }

    func testTrimZeroCents() {
        let result = 1_234.00.money(trimZeroCents: true)
        XCTAssertEqual(result, "$1,234")
    }

    func testNoCentsIncluded() {
        let result = 1_234.56.money(includeCents: false)
        XCTAssertEqual(result, "$1,234")
    }

    func testNegativeNoCentsIncluded() {
        let result = (-1_234.56).money(includeCents: false)
        XCTAssertEqual(result, "-$1,234")
    }

    func testPositiveDollarAmountExtended() {
        let result = 1_234.56789.moneyExtended()
        XCTAssertEqual(result, "$1,234.5679")
    }

    func testNegativeDollarAmountExtended() {
        let result = (-1_234.56789).moneyExtended()
        XCTAssertEqual(result, "-$1,234.5679")
    }

    func testZeroDollarAmountExtended() {
        let result = 0.00.moneyExtended()
        XCTAssertEqual(result, "$0")
    }

    func testPositiveDollarAmountWithDecimalPlacesExtended() {
        let result = 1_234.5678912345.moneyExtended(decimalPlaces: 8)
        XCTAssertEqual(result, "$1,234.56789123")
    }

    func testNegativeDollarAmountWithDecimalPlacesExtended() {
        let result = (-1_234.5678912345).moneyExtended(decimalPlaces: 8)
        XCTAssertEqual(result, "-$1,234.56789123")
    }

    func testZeroDollarAmountWithDecimalPlacesExtended() {
        let result = 0.00.moneyExtended(decimalPlaces: 8)
        XCTAssertEqual(result, "$0")
    }

    func testSimpleStrForInteger() {
        let value: Double = 10.0
        let str = value.simpleStr(2)
        XCTAssertEqual(str, "10")
    }

    func testSimpleStrForOneDecimalPlace() {
        let value: Double = 1.2
        let str = value.simpleStr(2)
        XCTAssertEqual(str, "1.2")
    }

    func testSimpleStrForTwoDecimalPlaces() {
        let value: Double = 1.23
        let str = value.simpleStr(2)
        XCTAssertEqual(str, "1.23")
    }

    func testSimpleStrForMoreThanTwoDecimalPlaces() {
        let value: Double = 1.234
        let str = value.simpleStr(2)
        XCTAssertEqual(str, "1.23")
    }

    func testSimpleStrForLessThanOne() {
        let value: Double = 0.1
        let str = value.simpleStr(2)
        XCTAssertEqual(str, "0.1")
    }

    func testSimpleStrForZero() {
        let value: Double = 0.0
        let str = value.simpleStr(2)
        XCTAssertEqual(str, "0")
    }

    func testSimpleStrForNegativeValue() {
        let value: Double = -1.23
        let str = value.simpleStr(2)
        XCTAssertEqual(str, "-1.23")
    }

    func testSimpleStrForCommas() {
        let value: Double = 10_000_000.00
        let str = value.simpleStr(useCommas: true)
        XCTAssertEqual(str, "10,000,000")
    }

    func testSimpleStrForCommasNegativeValue() {
        let value: Double = -9_000.00
        let str = value.simpleStr(useCommas: true)
        XCTAssertEqual(str, "-9,000")
    }

    func testSimpleStrDefault() {
        let value: Double = 1_234.5678
        let str = value.simpleStr()
        XCTAssertEqual(str, "1234.6")
    }

    func testSimpleStrWithTwoDecimalPlaces() {
        let value: Double = 1_234.5678
        let str = value.simpleStr(2)
        XCTAssertEqual(str, "1234.57")
    }

    func testSimpleStrWithoutCommas() {
        let value: Double = 10_000_000.00
        let str = value.simpleStr(useCommas: false)
        XCTAssertEqual(str, "10000000")
    }

    func testSimpleStrForZeroValue() {
        let value: Double = 0.0
        let str = value.simpleStr(useCommas: true)
        XCTAssertEqual(str, "0")
    }

    func testSimpleStrForFractionalValue() {
        let value: Double = 0.123456
        let str = value.simpleStr(4, useCommas: true)
        XCTAssertEqual(str, "0.1235")
    }

    func testSimpleStrForFractionalValueWithoutRounding() {
        let value: Double = 0.123456
        let str = value.simpleStr(6, useCommas: true)
        XCTAssertEqual(str, "0.123456")
    }

    func testSimpleStrForLargeFractionalValueWithCommas() {
        let value: Double = 1_234_567.891011
        let str = value.simpleStr(2, useCommas: true)
        XCTAssertEqual(str, "1,234,567.89")
    }

    func testSimpleStrForNegativeFractionalValue() {
        let value: Double = -1_234.5678
        let str = value.simpleStr(2, useCommas: true)
        XCTAssertEqual(str, "-1,234.57")
    }

    func testSimpleStrForVerySmallValue() {
        let value: Double = 0.000012345678
        let str = value.simpleStr(8, useCommas: true)
        XCTAssertEqual(str, "0.00001235")
    }

    func testSimpleStrForVeryLargeValue() {
        let value: Double = 1_000_000_000_000.12345678
        let str = value.simpleStr(2, useCommas: true)
        XCTAssertEqual(str, "1,000,000,000,000.12")
    }
}
