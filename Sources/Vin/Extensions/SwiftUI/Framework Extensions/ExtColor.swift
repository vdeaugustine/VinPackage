//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public extension Color {
    /// This is an initializer that takes in a hex string (with or without #) and converts it to a SwiftUI Color
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        let validHex = Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64

        if validHex {
            switch hex.count {
                case 3: // RGB (12-bit)
                    (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
                case 6: // RGB (24-bit)
                    (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
                case 8: // ARGB (32-bit)
                    (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
                default:
                    (a, r, g, b) = (0, 0, 0, 0) // Default to transparent black
            }
        } else {
            // Handle invalid hex input by setting color to transparent black
            (a, r, g, b) = (0, 0, 0, 0)
        }

        self.init(.sRGB,
                  red: Double(r) / 255.0,
                  green: Double(g) / 255.0,
                  blue: Double(b) / 255.0,
                  opacity: Double(a) / 255.0)
    }

    @available(iOS 14.0, *)
    var uiColor: UIColor { .init(self) }

    typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

    @available(iOS 14.0, *)
    var rgba: RGBA? {
        var (r, g, b, a): RGBA = (0, 0, 0, 0)
        return uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) ? (r, g, b, a) : nil
    }

    @available(iOS 14.0, *)
    var hexaRGB: String? {
        guard let (red, green, blue, _) = rgba else { return nil }
        return String(format: "#%02X%02X%02X",
                      lround(Double(red) * 255),
                      lround(Double(green) * 255),
                      lround(Double(blue) * 255))
    }

    @available(iOS 14.0, *)
    var hexaRGBA: String? {
        guard let (red, green, blue, alpha) = rgba else { return nil }
        return String(format: "#%02X%02X%02X%02X",
                      lround(Double(red) * 255),
                      lround(Double(green) * 255),
                      lround(Double(blue) * 255),
                      lround(Double(alpha) * 255))
    }

    /// A static property of the Color type that generates a random color.
    ///
    /// - Returns: A randomly-generated Color object.
    ///
    /// This property generates a random color by creating a Color object with randomly-generated values for its red, green, and blue components. The random(in:) method of the Double type is used to generate random values between 0 and 255 for each component, which are then divided by 255 to convert them to the appropriate range for the Color initializer.

    /// The resulting Color object is then returned as the result of this property.
    static var random: Color {
        Color(red: .random(in: 0 ... 255) / 255, green: .random(in: 0 ... 255) / 255, blue: .random(in: 0 ... 255) / 255)
    }

    /// The same background color as a SwiftUI list
    static let listBackgroundColor: Color = {
        if #available(iOS 15, *) {
            return Color(uiColor: .tertiarySystemGroupedBackground)
        } else {
            return Color(hex: UIColor.tertiarySystemGroupedBackground.hex)
        }

    }()

    /// Returns the color components (red, green, blue, and opacity) as a tuple.
    ///
    /// Uses the native color representation (`UIColor` on iOS, `NSColor` on macOS)
    /// to extract the components.
    ///
    /// - Returns: A tuple containing the red, green, blue, and opacity components of the color.
    @available(iOS 14.0, *)
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        #if canImport(UIKit)
            typealias NativeColor = UIColor
        #elseif canImport(AppKit)
            typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        // Attempt to get the color components from the native color representation.
        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }

    /// Returns a `LinearGradient` with the current color and a lighter color based on the `brightnessConstant`.
    ///
    /// - Parameters:
    ///   - brightnessConstant: An optional `CGFloat` value to adjust the brightness of the lighter color. Default value is `nil`.
    ///                         If `nil`, the function will use its internal algorithm to determine the lighter color.
    /// - Returns: A `LinearGradient` with two color stops: the current color, and a lighter color.
    @available(iOS 15.0, *)
    func getGradient(brightnessConstant: CGFloat? = nil) -> LinearGradient {
        LinearGradient(stops: [.init(color: self, location: 0.1), .init(color: getLighterColorForGradient(brightnessConstant), location: 2)], startPoint: .bottom, endPoint: .topLeading)
    }

    /// Returns a lighter color by increasing the RGB components by the specified `increaseAmount`, or by the default value of 40 if not provided.
    ///
    /// - Parameters:
    ///   - increaseAmount: An optional `CGFloat` value to adjust the brightness of the lighter color. Default value is `nil`.
    ///                     If `nil`, the function will use a default increase amount of 40 for each component.
    /// - Returns: A `Color` object representing the lighter color.
    @available(iOS 15.0, *)
    func getLighterColorForGradient(_ increaseAmount: CGFloat? = nil) -> Color {
        var b = components.blue * 255
        var r = components.red * 255
        var g = components.green * 255

        b += increaseAmount ?? 40
        r += increaseAmount ?? 40
        g += increaseAmount ?? 40

        if b > 255 { b = 255 }
        if r > 255 { r = 255 }
        if g > 255 { g = 255 }

        return Color(uiColor: .init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1))
    }
}
