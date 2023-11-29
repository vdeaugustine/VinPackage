//
//  SwiftUIView.swift
//
//
//  Created by Vincent DeAugustine on 11/28/23.
//

import SwiftUI

/// A SwiftUI view that represents a `UITextField` for currency input.
///
/// This structure conforms to `UIViewRepresentable` and creates a `UITextField` specifically for handling
/// currency input. It formats the text input as currency and limits the number of characters that can be entered.
///
/// - Important:
///   Requires iOS 13.0 or later.
///
/// ## Topics
///
/// ### Initializers
/// - `init(value:isFocused:characterLimit:customizer:)`
///
/// ### Instance Methods
/// - `makeUIView(context:)`
/// - `updateUIView(_:context:)`
/// - `makeCoordinator()`
///
/// ### Nested Types
/// - `Coordinator`
///
@available(iOS 13.0, *)
public struct CurrencyTextField: UIViewRepresentable {
    /// A binding to the string value representing the currency amount.
    @Binding var value: String

    /// A binding to a Boolean value that determines whether the text field is focused.
    @Binding var isFocused: Bool

    /// The maximum number of characters allowed in the text field. Defaults to 12.
    var characterLimit: Int = 12

    /// An optional closure for additional customization of the `UITextField`.
    var customizer: ((UITextField) -> Void)?

    /// Formats a string as a currency value.
    ///
    /// This static method takes a string representing a numeric value and formats it as a currency.
    /// The default currency code used is "USD".
    ///
    /// - Parameter string: The string to be formatted.
    /// - Returns: A formatted currency string.
    static func formatAsCurrency(string: String) -> String {
        let intValue = Int(string) ?? 0
        let dollars = Double(intValue) / 100.0

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"

        return formatter.string(from: NSNumber(value: dollars)) ?? "$0.00"
    }

    /// Creates the `UITextField` instance to be managed by SwiftUI.
    ///
    /// - Parameter context: The context in which the view is created.
    /// - Returns: A configured `UITextField` instance.
    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.keyboardType = .numberPad
        textField.delegate = context.coordinator

        customizer?(textField)
        if isFocused {
            textField.becomeFirstResponder()
        }
        return textField
    }

    /// Updates the `UITextField` when the SwiftUI view's state changes.
    ///
    /// - Parameters:
    ///   - uiView: The `UITextField` managed by SwiftUI.
    ///   - context: The context in which the view is updated.
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = CurrencyTextField.formatAsCurrency(string: value)
        customizer?(uiView)
        if isFocused {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }

    /// Creates a coordinator to manage the interaction between the `UITextField` and SwiftUI.
    ///
    /// - Returns: A `Coordinator` instance for managing events.
    public func makeCoordinator() -> Coordinator {
        Coordinator(self, characterLimit: characterLimit)
    }

    /// A class that acts as a delegate for the `UITextField`.
    ///
    /// This class conforms to `UITextFieldDelegate` and manages the behavior of the currency text field,
    /// such as character input validation and focus state.
    public class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CurrencyTextField
        var characterLimit: Int

        init(_ textField: CurrencyTextField, characterLimit: Int) {
            self.parent = textField
            self.characterLimit = characterLimit
        }

        /// Controls the changes to the characters in the text field.
        ///
        /// This method ensures that only numeric input is accepted and that the character limit is not exceeded.
        /// It also formats the input as currency.
        ///
        /// - Parameters:
        ///   - textField: The `UITextField` being edited.
        ///   - range: The range of characters being changed.
        ///   - string: The replacement string for the given range.
        /// - Returns: A Boolean value indicating whether the change should be made.
        public func textField(_ textField: UITextField,
                              shouldChangeCharactersIn range: NSRange,
                              replacementString string: String)
            -> Bool {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }

            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            let numericString = updatedText.filter("0123456789".contains)

            if numericString.count > characterLimit {
                return false
            }

            parent.value = numericString
            textField.text = CurrencyTextField.formatAsCurrency(string: numericString)
            return false
        }

        /// Handles the event when the text field begins editing.
        ///
        /// - Parameter textField: The `UITextField` that started editing.
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isFocused = true
        }

        /// Handles the event when the text field ends editing.
        ///
        /// - Parameter textField: The `UITextField` that ended editing.
        public func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isFocused = false
        }
    }
}

@available(iOS 13.0, *)
#Preview {
    VStack {
        Text("Hello")
        CurrencyTextField(value: .constant("123"),
                          isFocused: .constant(true),
                          characterLimit: 100) {
            $0.font = .systemFont(ofSize: 50, weight: .bold)
        }
        .frame(height: 100)
    }
}
