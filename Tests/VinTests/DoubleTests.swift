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
        let result = 1_234.56.formattedForMoney()
        XCTAssertEqual(result, "$1,234.56")
    }

    func testNegativeDollarAmount() {
        let result = (-1_234.56).formattedForMoney()
        XCTAssertEqual(result, "-$1,234.56")
    }

    func testZeroDollarAmount() {
        let result = 0.00.formattedForMoney()
        XCTAssertEqual(result, "$0")
    }

    func testTrimZeroCents() {
        let result = 1_234.00.formattedForMoney(trimZeroCents: true)
        XCTAssertEqual(result, "$1,234")
    }

    func testNoCentsIncluded() {
        let result = 1_234.56.formattedForMoney(includeCents: false)
        XCTAssertEqual(result, "$1,234")
    }

    func testNegativeNoCentsIncluded() {
        let result = (-1_234.56).formattedForMoney(includeCents: false)
        XCTAssertEqual(result, "-$1,234")
    }

    func testPositiveDollarAmountExtended() {
        let result = 1_234.56789.formattedForMoneyExtended()
        XCTAssertEqual(result, "$1,234.5679")
    }

    func testNegativeDollarAmountExtended() {
        let result = (-1_234.56789).formattedForMoneyExtended()
        XCTAssertEqual(result, "-$1,234.5679")
    }

    func testZeroDollarAmountExtended() {
        let result = 0.00.formattedForMoneyExtended()
        XCTAssertEqual(result, "$0")
    }

    func testPositiveDollarAmountWithDecimalPlacesExtended() {
        let result = 1_234.5678912345.formattedForMoneyExtended(decimalPlaces: 8)
        XCTAssertEqual(result, "$1,234.56789123")
    }

    func testNegativeDollarAmountWithDecimalPlacesExtended() {
        let result = (-1_234.5678912345).formattedForMoneyExtended(decimalPlaces: 8)
        XCTAssertEqual(result, "-$1,234.56789123")
    }

    func testZeroDollarAmountWithDecimalPlacesExtended() {
        let result = 0.00.formattedForMoneyExtended(decimalPlaces: 8)
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
}
