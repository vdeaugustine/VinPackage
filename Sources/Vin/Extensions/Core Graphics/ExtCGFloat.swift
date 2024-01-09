//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 1/9/24.
//

import Foundation
import CoreGraphics

public extension CGFloat {
    /// Provides a convenient method for rounding a CGFloat value to a specified number of decimal places.
    /// - Parameter places: The number of decimal places to round to.
    /// - Returns: The rounded CGFloat value.
    func roundTo(places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
    
    /// Returns a string representation of a rounded Float value, with options to remove trailing zeros and/or leading zeros before the decimal point.
    /// - Parameters:
    /// - places: The number of decimal places to round to. Defaults to 1.
    /// - removeFrontZero: A Boolean value indicating whether to remove leading zeros before the decimal point. Defaults to false.
    /// - Returns: A string representation of the rounded Float value, with optional formatting applied.
    func simpleStr(_ places: Int = 1, _ removeFrontZero: Bool = false) -> String {
        let rounded = roundTo(places: places)
        if rounded.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(rounded))
        } else {
            if removeFrontZero {
                let split = String(Double(rounded)).components(separatedBy: ".")
                if let back = split.safeGet(at: 1) {
                    return "." + back
                }
                return String(Double(rounded))
            }

            return String(Double(rounded))
        }
    }
}
