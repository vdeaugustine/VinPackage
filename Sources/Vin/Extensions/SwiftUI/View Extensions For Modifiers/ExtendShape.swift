//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 11/21/23.
//

import Foundation
import SwiftUI

// MARK: - RoundedCorner

/// A shape for creating a view with selectively rounded corners.
///
/// `RoundedCorner` conforms to the `Shape` protocol and allows specifying which corners to round and the radius for the rounding. 
/// This is used in conjunction with the `cornerRadius(_:corners:)` method in `View` extensions.
///
/// - Important: Requires **iOS 13.0** or later
///
@available(iOS 13.0, *)
public struct RoundedCorner: Shape {
    /// The radius of the corners.
    var radius: CGFloat = .infinity

    /// The corners to be rounded.
    var corners: UIRectCorner = .allCorners

    /// Creates a path that defines the shape of the view's frame.
    ///
    /// - Parameter rect: The rectangle to be drawn.
    ///
    /// - Returns: A path that describes the shape of the view's frame with specified rounded corners.
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
