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
            .foregroundColor(Color(hex: color))
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

// MARK: - PushTopModifier

/// A view modifier that aligns the content to the top of the available space.
///
/// Use `PushTopModifier` to align the content to the top of the available space,
/// with the specified horizontal alignment, and push it to the top by adding a spacer below the content.
///
/// Example usage:
/// ```
/// Text("Hello, World!")
///     .modifier(PushTopModifier(alignment: .center))
/// ```
@available(iOS 13.0, *)
public struct PushTopModifier: ViewModifier {
    /// The horizontal alignment for positioning the content within the available space.
    var alignment: HorizontalAlignment

    /// The view modifier's body, which applies the alignment and pushes the content to the top.
    ///
    /// - Parameter content: The content to be aligned and pushed to the top.
    /// - Returns: The modified content view.
    public func body(content: Content) -> some View {
        VStack(alignment: alignment) {
            content
            Spacer()
        }
    }
}

// MARK: - PaddingModifier

@available(iOS 13.0, *)
/// A modifier that applies horizontal and vertical padding to a view.
public struct PaddingModifier: ViewModifier {
    /// The horizontal padding to apply.
    let horizontal: CGFloat
    /// The vertical padding to apply.
    let vertical: CGFloat

    /// Applies the specified horizontal and vertical padding to the view.
    ///
    /// - Parameter content: The view to modify.
    /// - Returns: The modified view.
    public func body(content: Content) -> some View {
        content
            .padding(.horizontal, horizontal)
            .padding(.vertical, vertical)
    }
}

// MARK: - SearchableIfSearching

/// A `ViewModifier` that conditionally applies the `searchable` modifier based on the `isSearching` flag.
///
/// If `isSearching` is set to `true`, the view content will be made searchable. Otherwise, it will remain unmodified.
///
/// This is particularly useful when you only want to make a view searchable under certain conditions.
///
/// - Requires: iOS 15.0 and above.
///
/// - Example Usage:
///
/// ```
/// VStack {
///     Text("Hello World")
/// }
/// .modifier(SearchableIfSearching(isSearching: isCurrentlySearching, searchText: $currentSearchText))
/// ```
///
/// - SeeAlso: `searchable(_:suggestion:)` method in the `View` protocol.
@available(iOS 15.0, *)
public struct SearchableIfSearching: ViewModifier {
    /// Indicates whether the content should be made searchable.
    let isSearching: Bool

    /// A binding to the text that's being used for search.
    ///
    /// Changes to this binding will be reflected immediately in the view's search functionality.
    @Binding var searchText: String

    /// Produces the modified or unmodified content view based on the `isSearching` flag.
    ///
    /// - Parameter content: The original content that this modifier is applied to.
    ///
    /// - Returns: A view that's either searchable or unmodified based on the `isSearching` flag.
    @ViewBuilder
    public func body(content: Content) -> some View {
        if isSearching {
            content
                .searchable(text: $searchText)
        } else {
            content
        }
    }
}

// MARK: - FadeEffectModifier

/// A custom `ViewModifier` that applies a fading effect to a view.
///
/// This modifier uses a linear gradient to create a fading effect from the specified start opacity to the end opacity.
/// You can control the direction of the fade by specifying the start and end points.
///
/// - Availability: iOS 13.0+
/// - Note: To apply this modifier, use the `.modifier(FadeEffectModifier(...))` method on any view.
@available(iOS 13.0, *)
public struct FadeEffectModifier: ViewModifier {
    /// The starting opacity for the fade effect.
    ///
    /// The default value is `1` (fully opaque).
    var startOpacity: Double = 1

    /// The ending opacity for the fade effect.
    ///
    /// The default value is `0` (fully transparent).
    var endOpacity: Double = 0

    /// The starting point of the gradient used for the fade effect.
    ///
    /// The default value is `.center`.
    var startPoint: UnitPoint = .center

    /// The ending point of the gradient used for the fade effect.
    ///
    /// The default value is `.bottom`.
    var endPoint: UnitPoint = .bottom

    /// The body of the `FadeEffectModifier`.
    ///
    /// Applies a masking linear gradient to the content, creating a fading effect from `startOpacity` to `endOpacity`.
    ///
    /// - Parameter content: The content of the view that the modifier is applied to.
    /// - Returns: A view modified with a fading effect.
    public func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(gradient: Gradient(stops: [.init(color: Color.white.opacity(startOpacity), location: 0),
                                                          .init(color: Color.white.opacity(endOpacity), location: 1)]),
                startPoint: startPoint,
                endPoint: endPoint)
            )
    }
}

// MARK: - SecondLayerBackgroundModifier

/// A modifier that applies a second-layer background to a view.
///
/// `SecondLayerBackgroundModifier` is a `ViewModifier` that provides a way to apply
/// a secondary background layer to any SwiftUI view. It supports conditional modifications
/// like ignoring safe areas and applying corner radius, based on the provided properties.
///
/// - Requires: iOS 15.0 or later.
///
/// ## Topics
///
/// ### Creating a Second Layer Background Modifier
///
/// - ``init(ignoresSafeAreas:cornerRadius:)``
///
/// ### Applying the Modifier
///
/// - ``body(content:)``
///
@available(iOS 15.0, *)
public struct SecondLayerBackgroundModifier: ViewModifier {
    /// The current color scheme of the environment.
    @Environment(\.colorScheme) var colorScheme

    /// A Boolean value that determines whether the background ignores the safe area.
    var ignoresSafeAreas: Bool

    /// The corner radius for the background. If `nil`, no corner radius is applied.
    var cornerRadius: CGFloat?

    /// The content and behavior of the view.
    ///
    /// The modifier applies a background layer to the content, with optional modifications
    /// such as ignoring safe areas and applying a corner radius.
    ///
    /// - Parameter content: The original content of the view.
    ///
    /// - Returns: A modified view that includes the second-layer background.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Text("Hello, World!")
    ///     .modifier(SecondLayerBackgroundModifier(ignoresSafeAreas: true, cornerRadius: 10))
    /// ```
    ///
    /// In this example, the text will have a secondary background that ignores the safe areas
    /// and has a corner radius of 10 points.
    ///
    public func body(content: Content) -> some View {
        content
            .background {
                backgroundColor
                    .conditionalModifier(ignoresSafeAreas) {
                        $0.ignoresSafeArea()
                    }
                    .conditionalModifier(cornerRadius != nil) {
                        $0
                            .clipShape(
                                RoundedRectangle(cornerRadius: cornerRadius ?? 0)
                            )
                    }
            }
    }

    /// Computes the background color based on the current color scheme.
    ///
    /// - Returns: A `Color` that represents the background color.
    ///   The color changes depending on whether the color scheme is light or dark.
    ///
    private var backgroundColor: Color {
        switch colorScheme {
            case .light:
                return UIColor.secondarySystemFill.color
            case .dark:
                return UIColor.secondarySystemFill.color
            @unknown default:
                return UIColor.systemBackground.color
        }
    }
}

// MARK: - LayerBackgroundModifier

/// A modifier that applies a custom background layer to a view.
///
/// `LayerBackgroundModifier` is a `ViewModifier` designed to add a customizable
/// background layer to any SwiftUI view. It offers options for ignoring safe areas and
/// setting a corner radius, adapting to the current environment's color scheme.
///
/// - Requires: iOS 15.0 or later.
///
/// ## Topics
///
/// ### Creating a Layer Background Modifier
///
/// - ``init(ignoresSafeAreas:cornerRadius:)``
///
/// ### Applying the Modifier
///
/// - ``body(content:)``
///
@available(iOS 15.0, *)
struct LayerBackgroundModifier: ViewModifier {
    /// The current color scheme of the environment.
    @Environment(\.colorScheme) var colorScheme

    /// A Boolean value that indicates whether the background should ignore safe area insets.
    var ignoresSafeAreas: Bool

    /// The corner radius for the background. If `nil`, the background will not have rounded corners.
    var cornerRadius: CGFloat?

    /// The content and behavior of the view.
    ///
    /// Applies a background to the content, optionally ignoring safe areas and adding a corner radius,
    /// based on the given properties. The background color varies according to the current color scheme.
    ///
    /// - Parameter content: The original content of the view.
    ///
    /// - Returns: A view modified with a custom background layer.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Text("Hello, World!")
    ///     .modifier(LayerBackgroundModifier(ignoresSafeAreas: true, cornerRadius: 10))
    /// ```
    ///
    /// This example shows a text view with a background that extends to the edges of the safe area
    /// and has a corner radius of 10 points.
    ///
    func body(content: Content) -> some View {
        content
            .background {
                backgroundColor
                    .conditionalModifier(ignoresSafeAreas) {
                        $0.ignoresSafeArea()
                    }
                    .conditionalModifier(cornerRadius != nil) {
                        $0
                            .clipShape(
                                RoundedRectangle(cornerRadius: cornerRadius ?? 0)
                            )
                    }
            }
    }

    /// Determines the background color based on the current color scheme.
    ///
    /// - Returns: A `Color` that represents the background color, adapting to light and dark modes.
    ///
    private var backgroundColor: Color {
        switch colorScheme {
            case .light:
                return UIColor.secondarySystemGroupedBackground.color
            case .dark:
                return UIColor.tertiarySystemGroupedBackground.color
            @unknown default:
                return UIColor.systemBackground.color
        }
    }
}

// MARK: - MainBackgroundModifier

/// A modifier that applies a primary background layer to a view.
///
/// `MainBackgroundModifier` is a `ViewModifier` that adds a primary background layer
/// to any SwiftUI view. It offers options for setting a corner radius and ignoring safe
/// area insets, adapting dynamically to the current color scheme environment.
///
/// - Requires: iOS 15.0 or later.
///
/// ## Topics
///
/// ### Creating a Main Background Modifier
///
/// - ``init(ignoresSafeAreas:cornerRadius:)``
///
/// ### Applying the Modifier
///
/// - ``body(content:)``
///
@available(iOS 15.0, *)
struct MainBackgroundModifier: ViewModifier {
    /// The current color scheme of the environment.
    @Environment(\.colorScheme) var colorScheme

    /// A Boolean value indicating whether the background should ignore safe area insets.
    var ignoresSafeAreas: Bool

    /// The corner radius for the background. If `nil`, the background will not have rounded corners.
    var cornerRadius: CGFloat?

    /// The content and behavior of the view.
    ///
    /// Applies a primary background to the content, with options for corner radius and ignoring
    /// safe areas. The background color is determined by the current color scheme.
    ///
    /// - Parameter content: The original content of the view.
    ///
    /// - Returns: A view modified with a primary background layer.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Text("Welcome")
    ///     .modifier(MainBackgroundModifier(ignoresSafeAreas: false, cornerRadius: 8))
    /// ```
    ///
    /// In this example, the text view has a primary background with rounded corners of 8 points,
    /// and it does not extend beyond the safe area.
    ///
    func body(content: Content) -> some View {
        content
            .background {
                backgroundColor
                    .conditionalModifier(cornerRadius != nil) {
                        $0
                            .clipShape(
                                RoundedRectangle(cornerRadius: cornerRadius ?? 0)
                            )
                    }
                    .conditionalModifier(ignoresSafeAreas) {
                        $0
                            .ignoresSafeArea()
                    }
            }
    }

    /// Determines the background color based on the current color scheme.
    ///
    /// - Returns: A `Color` that represents the primary background color, adapting to light and dark modes.
    ///
    private var backgroundColor: Color {
        switch colorScheme {
            case .light:
                return UIColor.systemGroupedBackground.color
            case .dark:
                return UIColor.secondarySystemGroupedBackground.color
            @unknown default:
                return UIColor.systemBackground.color
        }
    }
}
