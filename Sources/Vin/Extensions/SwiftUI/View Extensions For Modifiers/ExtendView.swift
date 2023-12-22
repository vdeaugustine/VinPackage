//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 11/20/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public extension View {
    /// Retrieves the frame of the view in the specified coordinate space and passes it to the callback.
    ///
    /// Use this method to get the frame of the view in a given coordinate space. The frame is passed to the provided callback closure.
    ///
    /// - Parameters:
    ///   - scope: The coordinate space in which to calculate the frame. Defaults to `.global`.
    ///   - callback: A closure that is called with the frame of the view as a `CGRect`.
    ///
    /// - Returns: A modified view that calculates and provides the frame to the callback.
    /// - Important: Requires **iOS 13.0** or later.
    func getFrame(in scope: CoordinateSpace = .global,
                  _ callback: @escaping (CGRect) -> Void)
        -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        callback(geometry.frame(in: scope))
                    }
            }
        )
    }
}

/// An extension for `View` that allows rounding specific corners.
///
/// This extension introduces the `cornerRadius(_:corners:)` method to SwiftUI's `View`, enabling the rounding of specified corners of the view. It leverages the custom `RoundedCorner` shape to apply the corner radius only to the specified corners.
///
/// - Important:
///   - Requires **iOS 13.0** or later.
///
/// Example:
/// ```
/// Text("Hello, World!")
///     .cornerRadius(10, corners: [.topLeft, .bottomRight])
/// ```
@available(iOS 13.0, *)
public extension View {
    /// Applies a corner radius to specified corners of the view.
    /// - Example:
    /// ```swift
    /// Text("Hello, World!")
    ///     .cornerRadius(10, corners: [.topLeft, .bottomRight])
    /// ```
    ///
    /// - Parameters:
    ///   - radius: The radius to use when drawing rounded corners.
    ///   - corners: The corners of the view to round.
    ///
    /// - Returns: A view with the specified corners rounded.
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

/// A `View` extension to conditionally apply a modifier.
///
/// Use this extension to apply a modifier to a view only if a specific condition is true.
/// This extension adds a `conditionalModifier` method to any SwiftUI `View`, allowing you
/// to add modifiers conditionally without affecting the view hierarchy.
///

///
/// ## Topics
///
/// ### Using the Conditional Modifier
///
/// - ``conditionalModifier(_:modifier:)``
///
@available(iOS 13.0, *)
public extension View {
    /// Applies a modifier to the view conditionally.
    ///
    /// Use this method to apply a modifier to the view based on a condition. If the condition
    /// is `true`, the provided modifier is applied. If `false`, the view remains unmodified.
    ///
    /// - Parameters:
    ///   - condition: A `Bool` value determining whether to apply the modifier.
    ///   - modifier: A closure that takes the current view (`self`) and returns
    ///     a modified view. The closure is of type `@escaping (Self) -> T` where `T` is a `View`.
    ///
    /// - Returns: A view that is either modified by the provided closure if the condition
    ///   is `true`, or the original view if the condition is `false`.
    /// - Requires: iOS 13.0 or later.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Text("Hello, World!")
    ///     .conditionalModifier(true) { $0.foregroundColor(.blue) }
    /// ```
    ///
    /// In this example, the text will be colored blue because the condition is `true`.
    ///
    func conditionalModifier<T: View>(_ condition: Bool,
                                      _ modifier: @escaping (Self) -> T)
        -> some View {
        Group {
            if condition {
                modifier(self)
            } else {
                self
            }
        }
    }
}

@available(iOS 13.0, *)
public extension View {
    /// Extends the functionality of `View` to support setting both maximum width and height to infinity.
    ///
    /// This extension provides a convenient method to set the maximum width and height of a view to `.infinity`,
    /// effectively allowing the view to expand as much as the parent view allows. This is useful in scenarios where
    /// you want the view to occupy all available space, such as when creating a background view or a flexible layout.
    ///
    /// - Requires: iOS 13.0 or later.
    ///
    /// - Returns: A modified view that has its maximum width and height set to `.infinity`.
    ///
    /// Example:
    /// ```swift
    /// Text("Hello, World!")
    ///     .maxWidthAndHeight()
    /// ```
    func maxWidthAndHeight() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
