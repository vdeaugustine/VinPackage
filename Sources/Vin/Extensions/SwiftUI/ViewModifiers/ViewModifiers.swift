//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation
import SwiftUI

// MARK: - CustomFontModifier

@available(iOS 13.0, *)
/// A modifier that applies custom font, color, and weight settings to a view.
struct CustomFontModifier: ViewModifier {
    /// The font size to apply.
    let size: CGFloat
    /// The color to apply, specified as a hexadecimal string.
    let color: String
    /// The font weight to apply.
    let weight: Font.Weight

    /// Applies the specified font, color, and weight to the view.
    ///
    /// - Parameter content: The view to modify.
    /// - Returns: The modified view.
    public func body(content: Content) -> some View {
        content
            .font(.system(size: size))
            .foregroundColor(.hexStringToColor(hex: color))
    }
}


