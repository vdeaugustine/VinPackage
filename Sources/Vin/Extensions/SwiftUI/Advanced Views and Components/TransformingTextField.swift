//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 11/4/23.
//

import Combine
import Foundation
import SwiftUI

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
public struct TransformingTextField: View {
    var titleKey: String
    @Binding var text: String
    var characterLimit: Int?

    @StateObject private var textTransformer: TextTransformer

    public init(_ titleKey: String,
                text: Binding<String>,
                characterLimit: Int? = nil,
                _ transformer: @escaping (String) -> String) {
        self._text = text
        self.titleKey = titleKey
        self._textTransformer = StateObject(wrappedValue: TextTransformer(transformer: transformer,
                                                                          characterLimit: characterLimit,
                                                                          textBinding: text)) // Pass the binding here
    }

    public var body: some View {
        TextField(titleKey,
                  text: Binding(get: { self.textTransformer.transformedText },
                                set: { self.textTransformer.updateText($0) }))
    }

    public static let transformForMoney: (String) -> String = { input in
        var result = ""
        let filtered = input.filter { "0123456789".contains($0) }
        guard let dub = Double(filtered) else { return result }
        let divided = dub / 100
        // Assuming 'money' function is defined elsewhere to format the string as money
        let str = divided.money(trimZeroCents: false)
        for character in str {
            result.append(character)
        }
        return result
    }

    fileprivate class TextTransformer: ObservableObject {
        @Published var transformedText: String {
            didSet {
                // When transformedText is set, also update the original binding.
                if transformedText != textBinding.wrappedValue {
                    textBinding.wrappedValue = transformedText
                }
            }
        }

        let transformer: (String) -> String
        let characterLimit: Int?
        private var cancellables = Set<AnyCancellable>()
        var textBinding: Binding<String> // Add this line

        init(transformer: @escaping (String) -> String, characterLimit: Int?, textBinding: Binding<String>) {
            self.transformer = transformer
            self.characterLimit = characterLimit
            self.textBinding = textBinding // Initialize the binding
            self.transformedText = textBinding.wrappedValue // Initialize transformedText with the binding's initial value

            // Set up a publisher that reacts to changes in `transformedText`, applies the transformation, and ensures it executes on the main thread.
            $transformedText
                .dropFirst() // Drop the first value since it's already been initialized above
                .map(transformer)
                .receive(on: RunLoop.main)
                .sink { [weak self] newText in
                    self?.transformedText = newText
                }
                .store(in: &cancellables)
        }

        func updateText(_ newText: String) {
            if let characterLimit, newText.count > characterLimit {
                return
            }
            transformedText = transformer(newText)
        }
    }
}
