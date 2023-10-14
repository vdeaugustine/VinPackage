//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 10/3/23.
//

import Foundation
import SwiftUI
// MARK: - StringPlaceholderModifier

/// A view modifier that displays a placeholder text when the provided text is empty.
///
/// Use `StringPlaceholderModifier` when you want to display placeholder text in your custom text input UI.
/// When the text is empty, a placeholder text is shown in a designated position within the text input.
/// The placeholder text will be automatically hidden when user inputs text.
///
/// - Availability: iOS 15.0 and later.
@available(iOS 15.0, *)
public struct StringPlaceholderModifier: ViewModifier {

    /// A binding to the string that determines whether the placeholder is visible.
    ///
    /// When `text` is non-empty, the placeholder will not be visible.
    /// When `text` is empty, the placeholder is displayed with the specified `placeholder` text.
    @Binding var text: String
    
    /// The string that is displayed when `text` is empty.
    ///
    /// This text acts as a placeholder, hinting the user about the expected input.
    var placeholder: String
    
    /// The edge insets that define the padding for the placeholder.
    ///
    /// Use `insets` to control the position of the placeholder text within its containing view.
    /// - Note: A default value may look like `EdgeInsets(top: 9, leading: 4, bottom: 0, trailing: 0)`.
    var insets: EdgeInsets
    
    /// A view modifier that overlays a placeholder text on the modified content.
    ///
    /// When the `text` is empty, this view modifier creates a `ZStack` that overlays a placeholder `Text`
    /// view atop the modified content. The placeholder text is padded according to `insets` and
    /// displayed with secondary label color and 50% opacity. Tapping the modified content with empty
    /// `text` dismisses the keyboard.
    ///
    /// - Parameter content: The view to be modified.
    /// - Returns: A `ZStack` view that conditionally displays placeholder text.
    public func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                    .padding(insets)
                    .opacity(0.5)
            }
            content
                .onTapGesture {
                    if text.isEmpty {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
        }
    }
}



// MARK: - ViewPlaceholderModifier
@available(iOS 15.0, *)
public struct ViewPlaceholderModifier<Placeholder: View>: ViewModifier {
    @Binding var text: String
    var placeholder: Placeholder
    var insets: EdgeInsets // EdgeInsets(top: 9, leading: 4, bottom: 0, trailing: 0)
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                placeholder
                    .padding(insets)
            }
            content
                .onTapGesture {
                    if text.isEmpty {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
        }
    }
}




