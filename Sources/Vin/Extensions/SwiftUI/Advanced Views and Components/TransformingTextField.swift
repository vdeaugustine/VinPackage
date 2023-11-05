//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 11/4/23.
//

import Foundation
import SwiftUI
import Combine
// MARK: - TransformingTextField

/// A view that presents a text field which applies a transformation to the text input.
///
/// This structure defines a custom `TextField` view which takes a title, a text binding, and an optional character limit.
/// It uses a custom `TextTransformer` to apply a transformation to the text input, such as formatting or validation.
/// The transformation is provided by the caller as a closure that takes a `String` and returns a `String`.
///
/// The view observes the transformed text using the `@Published` property wrapper from the `TextTransformer` class,
/// which allows the UI to react to changes in the transformed text.
///
/// - Availability: iOS 14.0+
@available(iOS 14, *)
struct TransformingTextField: View {
    /// The title key for the text field, used as a label.
    var titleKey: String
    
    /// A binding to the text input from the parent view.
    @Binding var text: String
    
    /// An optional limit to the number of characters that can be input.
    var characterLimit: Int?
    
    /// The object that manages the transformation of the text.
    @StateObject private var textTransformer: TextTransformer
    
    /// Initializes a `TransformingTextField` with a title, text binding, optional character limit, and a transformation closure.
    ///
    /// - Parameters:
    ///   - titleKey: The title string identifying the text field.
    ///   - text: A binding to the source of truth for the text value in the parent view.
    ///   - characterLimit: An optional integer specifying the maximum number of characters allowed.
    ///   - transformer: A closure that takes a string as its input and returns a transformed string.
    init(_ titleKey: String,
         text: Binding<String>,
         characterLimit: Int? = nil,
         _ transformer: @escaping (String) -> String) {
        self._text = text
        self.titleKey = titleKey
        self._textTransformer = StateObject(wrappedValue: TextTransformer(transformer: transformer,
                                                                          characterLimit: characterLimit))
    }
    
    /// The content and behavior of the view.
    var body: some View {
        TextField(titleKey,
                  text: Binding(get: { self.textTransformer.transformedText },
                                set: { self.textTransformer.updateText($0) }))
    }
    
    // MARK: - TextTransformer
    
    /// A class that observes and transforms text input, limiting the number of characters if a limit is set.
    private class TextTransformer: ObservableObject {
        
        /// The text that has been transformed by the `transformer` closure.
        @Published var transformedText: String = ""
        
        /// The closure that defines how the text should be transformed.
        let transformer: (String) -> String
        
        /// The optional maximum number of characters allowed in the text.
        let characterLimit: Int?
        
        /// A set of any type that conforms to the `Cancellable` protocol, used to cancel the publisher when no longer needed.
        private var cancellables = Set<AnyCancellable>()
        
        /// Initializes a `TextTransformer` with a transformation closure and an optional character limit.
        ///
        /// - Parameters:
        ///   - transformer: A closure that takes a string as its input and returns a transformed string.
        ///   - characterLimit: An optional integer specifying the maximum number of characters allowed.
        init(transformer: @escaping (String) -> String, characterLimit: Int?) {
            self.transformer = transformer
            self.characterLimit = characterLimit
            // Set up a publisher that reacts to changes in `transformedText`, applies the transformation, and ensures it executes on the main thread.
            $transformedText
                .map(transformer)
                .receive(on: RunLoop.main)
                .sink { [weak self] newText in
                    self?.transformedText = newText
                }
                .store(in: &cancellables)
        }
        
        /// Updates the `transformedText` property with the new text after applying the transformation.
        /// If a character limit is set, it will not update the text if the new text exceeds the limit.
        ///
        /// - Parameter newText: The new text to be transformed and set.
        func updateText(_ newText: String) {
            if let characterLimit, newText.count > characterLimit {
                return
            }
            transformedText = transformer(newText)
        }
    }
}

