//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 1/9/24.
//

import XCTest
@testable import Vin

class CoreGraphicsTests: XCTestCase {
    
    // Test CGFloat.roundTo
    func testCGFloatRoundTo() {
        XCTAssertEqual(CGFloat(3.14159).roundTo(places: 2), 3.14)
        XCTAssertEqual(CGFloat(0.123456).roundTo(places: 3), 0.123)
        XCTAssertEqual(CGFloat(1.9999).roundTo(places: 0), 2.0)
    }
    
    // Test CGFloat.simpleStr
    func testCGFloatSimpleStr() {
        XCTAssertEqual(CGFloat(2.0).simpleStr(), "2")
        XCTAssertEqual(CGFloat(2.0).simpleStr(1, true), "2")
        XCTAssertEqual(CGFloat(0.12345).simpleStr(3), "0.123")
        XCTAssertEqual(CGFloat(1.230).simpleStr(2, true), ".23")
    }
    
    // Test CGSize.formattedString
    func testCGSizeFormattedString() {
        XCTAssertEqual(CGSize(width: 100.1234, height: 200.5678).formattedString(), "100 x 201")
        XCTAssertEqual(CGSize(width: 100.1234, height: 200.5678).formattedString(2), "100.12 x 200.57")
        XCTAssertEqual(CGSize(width: 0.9999, height: 1.1111).formattedString(1), "1 x 1.1")
    }


}
