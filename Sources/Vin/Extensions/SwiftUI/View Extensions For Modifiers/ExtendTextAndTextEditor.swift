//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 10/3/23.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
public extension TextEditor {
    /// Attaches a placeholder to the text editor, visible when the editor's text is empty.
    ///
    /// Use `placeholder(_:text:insets:)` to add placeholder text to a `TextEditor` instance,
    /// providing a visual indicator to the user for expected input when the editor is empty.
    /// ```swift
    /// TextEditor(text: $documentText)
    ///     .placeholder("Enter document text...", text: $documentText)
    /// }
    /// ```
    /// - Parameters:
    ///   - placeholder: A `String` value to be displayed when the text editor is empty.
    ///   - text: A binding to a `String` that represents the current text in the text editor.
    ///   - insets: The edge insets to offset the placeholder text within the `TextEditor`.
    ///             Defaults to `EdgeInsets(top: 9, leading: 4, bottom: 0, trailing: 0)`.
    /// - Returns: A `TextEditor` view that displays placeholder text when the editor is empty.
    /// - Important: Requires iOS 15 and above
    func placeholder(_ placeholder: String, text: Binding<String>, insets: EdgeInsets = EdgeInsets(top: 9, leading: 4, bottom: 0, trailing: 0)) -> some View {
        modifier(StringPlaceholderModifier(text: text, placeholder: placeholder, insets: insets))
    }

    func placeholder<Placeholder: View>(text: Binding<String>,
                                        insets: EdgeInsets = EdgeInsets(top: 9,
                                                                        leading: 4,
                                                                        bottom: 0,
                                                                        trailing: 0),
                                        @ViewBuilder placeholder: () -> Placeholder)
        -> some View {
        modifier(ViewPlaceholderModifier(text: text, placeholder: placeholder(), insets: insets))
    }
}
