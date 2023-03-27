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

// MARK: - DoubleAlertViewModifier

// A view modifier that displays an alert with a text field for editing a Double value.
@available(iOS 15.0, *)
struct DoubleAlertViewModifier: ViewModifier {
    // State variables for showing the alert and storing the edited value.
    @Binding var showAlert: Bool
    @Binding var value: Double
    
    // Optional title and message for the alert.
    var title: String?
    var message: String?
    
    // State variable for the value of the text field.
    @State private var textFieldValue: Double
    
    // Optional prompt for the text field and completion handler for when the alert is dismissed.
    let textFieldPrompt: String?
    let completion: ((Bool) -> Void)?
    
    // Initialize the view modifier with the given parameters.
    init(showAlert: Binding<Bool>, value: Binding<Double>, title: String? = nil, message: String? = nil, textFieldPrompt: String? = nil, completion: ((Bool) -> Void)? = nil) {
        // Set the binding variables.
        _showAlert = showAlert
        _value = value
        
        // Set the optional parameters.
        self.title = title
        self.message = message
        
        // Initialize the state variable with the current value.
        _textFieldValue = State(initialValue: value.wrappedValue)
        
        // Set the optional parameters.
        self.textFieldPrompt = textFieldPrompt
        self.completion = completion
    }
    
    // The body of the view modifier.
    func body(content: Content) -> some View {
        content
            // Show an alert with a text field for editing the value.
            .alert(title ?? "", isPresented: $showAlert) {
                // The text field for editing the value.
                TextField(textFieldPrompt ?? "Edit", value: $textFieldValue, format: .number)
                    .keyboardType(.decimalPad)
                
                // The "Submit" button saves the edited value and dismisses the alert.
                Button("Submit") {
                    value = textFieldValue
                    showAlert = false
                    completion?(true)
                }
                
                // The "Cancel" button dismisses the alert without saving the edited value.
                Button("Cancel", role: .cancel) {
                    showAlert = false
                }
            } message: {
                // An optional message for the alert.
                if let message = message {
                    Text(message)
                }
            }
    }
}




// MARK: - IntAlertViewModifier

// A view modifier that displays an alert with a text field for editing an Int value.
@available(iOS 15.0, *)
public struct IntAlertViewModifier: ViewModifier {
    // State variables for showing the alert and storing the edited value.
    @Binding var showAlert: Bool
    @Binding var value: Int
    
    // Optional title and message for the alert.
    var title: String?
    var message: String?
    
    // State variable for the value of the text field.
    @State private var textFieldValue: Int
    
    // Optional prompt for the text field and completion handler for when the alert is dismissed.
    let textFieldPrompt: String?
    let completion: ((Bool) -> Void)?
    
    // Initialize the view modifier with the given parameters.
    init(showAlert: Binding<Bool>, value: Binding<Int>, title: String? = nil, message: String? = nil, textFieldPrompt: String? = nil, completion: ((Bool) -> Void)? = nil) {
        // Set the binding variables.
        _showAlert = showAlert
        _value = value
        
        // Set the optional parameters.
        self.title = title
        self.message = message
        
        // Initialize the state variable with the current value.
        _textFieldValue = State(initialValue: value.wrappedValue)
        
        // Set the optional parameters.
        self.textFieldPrompt = textFieldPrompt
        self.completion = completion
    }
    
    // The body of the view modifier.
    public func body(content: Content) -> some View {
        content
            // Show an alert with a text field for editing the value.
            .alert(title ?? "", isPresented: $showAlert) {
                // The text field for editing the value.
                TextField(textFieldPrompt ?? "Edit", value: $textFieldValue, format: .number)
                    .keyboardType(.numberPad)
                
                // The "Submit" button saves the edited value and dismisses the alert.
                Button("Submit") {
                    // Make sure the value is not negative.
                    value = max(textFieldValue, 0)
                    showAlert = false
                    completion?(true)
                }
                
                // The "Cancel" button dismisses the alert without saving the edited value.
                Button("Cancel", role: .cancel) {
                    showAlert = false
                }
            } message: {
                // An optional message for the alert.
                if let message = message {
                    Text(message)
                }
            }
    }
}

