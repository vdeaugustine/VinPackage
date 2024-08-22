//
//  ColorTests.swift
//  Vin
//
//  Created by Vincent DeAugustine on 8/21/24.
//

import SwiftUI
import Vin
import XCTest

@available(iOS 14.0, *)
final class ColorTests: XCTestCase {
    
    // Helper function to compare hex strings with a small tolerance
    func assertEqualHexStrings(_ actual: String?, _ expected: String?, file: StaticString = #file, line: UInt = #line) {
        guard let actual = actual, let expected = expected else {
            XCTFail("Hex strings are nil", file: file, line: line)
            return
        }
        XCTAssertTrue(actual.lowercased() == expected.lowercased(), "Expected \(expected) but got \(actual)", file: file, line: line)
    }

    func testRGBHexInitialization() {
        let color = Color(hex: "#ff5733")
        XCTAssertEqual(Double(color.rgba?.red ?? 0), 1.0, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.green ?? 0), 0.341, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.blue ?? 0), 0.2, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.alpha ?? 0), 1.0, accuracy: 0.001)
    }

    func testARGBHexInitialization() {
        let color = Color(hex: "#80ff5733")
        XCTAssertEqual(Double(color.rgba?.red ?? 0), 1.0, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.green ?? 0), 0.341, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.blue ?? 0), 0.2, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.alpha ?? 0), 0.5, accuracy: 0.01)
    }

    func testShortRGBHexInitialization() {
        let color = Color(hex: "#f53")
        XCTAssertEqual(Double(color.rgba?.red ?? 0), 1.0, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.green ?? 0), 0.333, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.blue ?? 0), 0.2, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.alpha ?? 0), 1.0, accuracy: 0.001)
    }

    func testInvalidHexInitialization() {
        let color = Color(hex: "invalid")
        XCTAssertEqual(Double(color.rgba?.red ?? 0), 0.0, accuracy: 0.01)
        XCTAssertEqual(Double(color.rgba?.green ?? 0), 0.0, accuracy: 0.01)
        XCTAssertEqual(Double(color.rgba?.blue ?? 0), 0.0, accuracy: 0.001)
        XCTAssertEqual(Double(color.rgba?.alpha ?? 0), 0.0, accuracy: 0.01)
    }

    func testHexaRGBConversion() {
        let color = Color(hex: "#ff5733")
        assertEqualHexStrings(color.hexaRGB, "#ff5733")
    }

    func testHexaRGBAConversion() {
        let color = Color(hex: "#80ff5733")
        assertEqualHexStrings(color.hexaRGBA, "#ff573380")
    }

    func testAlphaDefaultedTo255() {
        let color = Color(hex: "#ff5733")
        assertEqualHexStrings(color.hexaRGBA, "#ff5733ff")
    }

    func testUIColorConversion() {
        let color = Color(hex: "#80ff5733")
        let uiColor = color.uiColor
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(Double(red), 1.0, accuracy: 0.001)
        XCTAssertEqual(Double(green), 0.341, accuracy: 0.001)
        XCTAssertEqual(Double(blue), 0.2, accuracy: 0.001)
        XCTAssertEqual(Double(alpha), 0.5, accuracy: 0.01)
    }
}
