//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension Color {
    /// A static property of the Color type that generates a random color.
    ///
    /// - Returns: A randomly-generated Color object.
    ///
    /// This property generates a random color by creating a Color object with randomly-generated values for its red, green, and blue components. The random(in:) method of the Double type is used to generate random values between 0 and 255 for each component, which are then divided by 255 to convert them to the appropriate range for the Color initializer.

    /// The resulting Color object is then returned as the result of this property.
    static public var random: Color {
        Color(red: .random(in: 0 ... 255) / 255, green: .random(in: 0 ... 255) / 255, blue: .random(in: 0 ... 255) / 255)
    }
    
    /// Converts a hexadecimal color string into a UIColor object.
    ///
    /// - Parameter hex: The hexadecimal color string to convert.
    /// - Returns: A UIColor object representing the specified color.
    static public func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                       alpha: CGFloat(1.0))
    }

    /// Converts a hexadecimal color string into a SwiftUI Color.
    ///
    /// - Parameter hex: The hexadecimal color string to convert.
    /// - Returns: A Color object representing the specified color.
    static public func hexStringToColor(hex: String) -> Color {
        Color(hexStringToUIColor(hex: hex))
    }
    
    /// The same background color as a SwiftUI list in light mode 
    static let listBackgroundColor: Color = hexStringToColor(hex: "F2F2F7")
}
