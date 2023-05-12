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
}
