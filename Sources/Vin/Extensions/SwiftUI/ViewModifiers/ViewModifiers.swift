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
public struct CustomFontModifier: ViewModifier {
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
public struct DoubleAlertViewModifier: ViewModifier {
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
    public init(showAlert: Binding<Bool>, value: Binding<Double>, title: String? = nil, message: String? = nil, textFieldPrompt: String? = nil, completion: ((Bool) -> Void)? = nil) {
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

// MARK: - TextFieldAlert

@available(iOS 15.0, *)
public struct TextFieldAlert: ViewModifier {
    // State variables for showing the alert and storing the edited value.
    @Binding var showAlert: Bool
    @Binding var text: String

    // Optional title and message for the alert.
    var title: String?
    var message: String?

    let oldValue: String

    // Optional prompt for the text field and completion handler for when the alert is dismissed.
    let textFieldPrompt: String?
    let completion: ((Bool) -> Void)?

    /**
     Initializes the view modifier with the given parameters.

     - Parameters:
        - showAlert: A binding to a boolean that controls whether the alert is shown.
        - text: A binding to the string value to edit.
        - title: An optional title for the alert.
        - message: An optional message for the alert.
        - textFieldPrompt: An optional prompt for the text field.
        - completion: An optional completion handler that is called when the alert is dismissed. If the user clicks the "Submit" button, the completion handler is called with a `true` value. If the user clicks the "Cancel" button, the completion handler is called with a `false` value.
     */
    public init(showAlert: Binding<Bool>, text: Binding<String>, title: String? = nil, message: String? = nil, textFieldPrompt: String? = nil, completion: ((Bool) -> Void)? = nil) {
        // Set the binding variables.
        _showAlert = showAlert
        _text = text

        // Set the optional parameters.
        self.title = title
        self.message = message

        // Set the optional parameters.
        self.textFieldPrompt = textFieldPrompt
        self.completion = completion

        self.oldValue = text.wrappedValue
    }

    // The body of the view modifier.
    public func body(content: Content) -> some View {
        content
            // Show an alert with a text field for editing the value.
            .alert(title ?? "", isPresented: $showAlert) {
                // The text field for editing the value.
                //                TextField(textFieldPrompt ?? "", value: $text)
                //                    .keyboardType(.decimalPad)
                TextField(textFieldPrompt ?? "", text: $text)

                // The "Submit" button saves the edited value and dismisses the alert.
                Button("Submit") {
                    showAlert = false
                    completion?(true)
                }

                // The "Cancel" button dismisses the alert without saving the edited value.
                Button("Cancel", role: .cancel) {
                    showAlert = false
                    text = oldValue
                }
            } message: {
                // An optional message for the alert.
                if let message = message {
                    Text(message)
                }
            }
    }
}

// MARK: - PutInNavView

/**
  A view modifier that wraps a view in a `NavigationView` and sets the navigation title display mode.

  Use this modifier to wrap a view in a `NavigationView` and set the display mode of the navigation title. The `displayMode` parameter determines the display mode of the navigation title.

 ``` Example:
  Text("Hello, World!")
     .navigationBarDisplayMode(.inline)

  */
@available(iOS 14.0, *)
public struct PutInNavView: ViewModifier {
    /// The display mode of the navigation title.
    var displayMode: NavigationBarItem.TitleDisplayMode

    /**
     Applies the `NavigationBarDisplayModeModifier` to a view.

     This method wraps a view in a `NavigationView` and sets the display mode of the navigation title. The `navigationBarTitleDisplayMode` modifier is applied to the content with the `displayMode` parameter.

     - Parameter content: The content to wrap in a `NavigationView`.
     - Returns: A modified version of the content with the `NavigationBarDisplayModeModifier` applied.
     */
    public func body(content: Content) -> some View {
        NavigationView {
            content
                .navigationBarTitleDisplayMode(displayMode)
        }
    }
}

// MARK: - TabModifier

/// A generic `ViewModifier` that adds a tab item to a view with a system image and the associated description.
///
/// The `TabModifier` requires a type `T` that conforms to `RawRepresentable`, `Hashable`, and `CustomStringConvertible` protocols.
/// The `RawValue` of the type `T` must be of type `String`.
///
/// Usage:
///
/// ```swift
/// TabView {
///     Text("Tab 1")
///         .modifier(TabModifier(tab: MyTabEnum.tab1, systemImage: "star.fill"))
///     Text("Tab 2")
///         .modifier(TabModifier(tab: MyTabEnum.tab2, systemImage: "heart.fill"))
/// }
/// ```
///
/// - Parameters:
///   - tab: A value of type `T`, representing the current tab.
///   - systemImage: A `String` representing the system image to be used as the icon for the tab item.
///
@available(iOS 14.0, *)
public struct TabModifier<T: RawRepresentable>: ViewModifier where T.RawValue == String, T: Hashable, T: CustomStringConvertible {
    public var tab: T
    public var systemImage: String

    /// The body of the `ViewModifier`. Applies the tab item and tag to the given `content`.
    ///
    /// - Parameter content: The content to apply the modifier to.
    ///
    /// - Returns: A view with the tab item and tag applied.
    ///
    public func body(content: Content) -> some View {
        content
            .tabItem {
                Label(tab.description, systemImage: systemImage)
            }
            .tag(tab)
    }
}
