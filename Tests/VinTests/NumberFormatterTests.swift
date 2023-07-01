//
//  NumberFormatterTests.swift
//  
//
//  Created by Vincent DeAugustine on 6/30/23.
//

import XCTest

class NumberFormatterTests: XCTestCase {
    
    func testDecimalPlaces() {
        let formatter = NumberFormatter.custom(decimalPlaces: 2)
        let formattedNumber = formatter.string(from: NSNumber(value: 1234.5678))
        XCTAssertEqual(formattedNumber, "1,234.57")
    }

    func testMinAndMaxPlaces() {
        let formatter = NumberFormatter.custom(minPlaces: 1, maxPlaces: 3)
        let formattedNumber1 = formatter.string(from: NSNumber(value: 1234.5))
        let formattedNumber2 = formatter.string(from: NSNumber(value: 1234.5678))
        XCTAssertEqual(formattedNumber1, "1,234.5")
        XCTAssertEqual(formattedNumber2, "1,234.568")
    }

    func testLocale() {
        let formatter = NumberFormatter.custom(decimalPlaces: 2, locale: Locale(identifier: "de_DE"))
        let formattedNumber = formatter.string(from: NSNumber(value: 1234.56))
        XCTAssertEqual(formattedNumber, "1.234,56")
    }

    func testGroupingSeparator() {
        let formatter = NumberFormatter.custom(decimalPlaces: 2, groupingSeparator: ".")
        let formattedNumber = formatter.string(from: NSNumber(value: 1234567.89))
        XCTAssertEqual(formattedNumber, "1.234.567.89")
    }


    func testNoGroupingSeparator() {
        let formatter = NumberFormatter.custom(decimalPlaces: 2, useGroupingSeparator: false)
        let formattedNumber = formatter.string(from: NSNumber(value: 1234567.89))
        XCTAssertEqual(formattedNumber, "1234567.89")
    }
}

