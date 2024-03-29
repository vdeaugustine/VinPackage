//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation
import SwiftUI

// MARK: - View Extensions

@available(iOS 13.0, *)
public extension View {
    /// Applies a custom font, color, and weight to the view.
    ///
    /// - Parameters:
    ///   - size: The font size to apply.
    ///   - color: The color to apply, specified as a hexadecimal string.
    ///   - weight: The font weight to apply. Defaults to regular weight.
    /// - Returns: The modified view.
    func customFont(size: CGFloat, color: String, weight: Font.Weight = .regular) -> some View {
        modifier(CustomFontModifier(size: size, color: color, weight: weight))
    }

    /// A view modifier that adds horizontal spacing between two views.
    ///
    /// The spacedOut modifier can be used to add extra space between two views, pushing them further away from each other.
    /// This modifier is implemented as an HStack with the first view on the left, a Spacer in the middle, and the
    /// second view on the right.
    ///
    /// - Parameter otherView: A closure returning a View that will be spaced out from the original view.
    /// - Returns: A modified version of the view with additional space added between it and the otherView.
    func spacedOut<Content: View>(@ViewBuilder otherView: () -> Content) -> some View {
        // Create an HStack with the original view on the left, a Spacer in the middle, and the otherView on the right.
        HStack {
            self
            Spacer()
            otherView()
        }
    }

    /// A function that returns a View that creates a spaced out View with a left-pushed layout.
    ///
    /// Use this function to push a View to the left, while maintaining a spaced-out layout.
    ///
    /// - Returns: A SwiftUI View that has been left-pushed with spacing applied.
    ///
    /// - Note: This function uses the Spacer view to create the space between views, and the spacedOut modifier to apply the spacing to the returned View.
    func pushLeft() -> some View {
        spacedOut {
            Spacer()
        }
    }

    /// A view modifier that centers a view within its parent view.
    ///
    /// The centerInParentView modifier can be used to center a view vertically and horizontally within its parent view.
    ///
    /// - Returns: A modified version of the view that is centered within its parent view.
    func centerInParentView() -> some View {
        // Use a VStack to center the view vertically within its parent view.
        VStack(alignment: .center) {
            self
        }
        // Use the frame() modifier to set the width of the view to the maximum available width of its parent view.
        .frame(maxWidth: .infinity)
    }

    /// A utility function that returns a View with a toolbar item containing a "Save" button in the navigation bar trailing area.
    ///
    /// - Parameter execute: A closure to execute when the "Save" button is tapped.
    ///
    /// - Returns: A View with a toolbar item containing a "Save" button in the navigation bar trailing area.
    ///
    /// This function uses the SwiftUI toolbar modifier to add a toolbar to the view hierarchy. It then creates a ToolbarItem with a placement of .navigationBarTrailing to specify the location of the item within the toolbar. Finally, it creates a Button with the label "Save" and the action of execute() when tapped. The closure execute is passed as a parameter to this function, and will be executed when the "Save" button is tapped.
    @available(iOS 14.0, *)
    func toolbarSave(_ execute: @escaping () -> Void) -> some View {
        toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    execute()
                }
            }
        }
    }

    /// A utility function that returns a View with a toolbar item containing a navigation link with a "plus" symbol icon.
    ///
    /// - Parameter destination: A closure that returns a View to be displayed when the navigation link is tapped.
    ///
    /// - Returns: A View with a toolbar item containing a navigation link with a "plus" symbol icon.
    ///
    /// This function uses the SwiftUI toolbar modifier to add a toolbar to the view hierarchy. It then creates a ToolbarItem with a placement of .navigationBarTrailing to specify the location of the item within the toolbar. Inside the toolbar item, it creates a NavigationLink with a label of an image of a "plus" symbol. The destination view is provided by the destination closure. The closure is passed as a parameter to this function and is executed when the navigation link is tapped.
    ///
    /// The destination parameter must return a type that conforms to the View protocol.
    @available(iOS 14.0, *)
    func toolbarAdd<Destination>(@ViewBuilder destination: () -> Destination) -> some View where Destination: View {
        toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    destination()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    /// A utility function that returns a View with all its parts tappable, i.e., user interactions are detected for the entire view.
    ///
    /// - Parameter alignment: The alignment to be used for the ZStack.
    ///
    /// - Returns: A View with all its parts tappable.
    ///
    /// This function returns a ZStack with the current view on the bottom and a Color view on the top with an opacity of 0.001. This allows the ZStack to detect user interactions for the entire view, even if the top Color view is transparent.
    ///
    /// The alignment parameter is an optional parameter that can be used to specify the alignment of the views within the ZStack. If no alignment is specified, the default value of .center is used.
    @available(iOS 15.0, *)
    func allPartsTappable(alignment: Alignment? = nil) -> some View {
//        ZStack(alignment: alignment ?? .center) {
//            self
//            Color.white
//                .opacity(0.001)
//        }

        overlay {
            Color.white.opacity(0.001)
        }
    }

    /// A utility function that hides the software keyboard if it is currently visible.
    ///
    /// This function sends the resignFirstResponder action to the shared UIApplication object. This action resigns the first responder status of the current responder, which is the keyboard in this case. By sending this action, the keyboard is hidden if it is currently visible on the screen.
    ///
    /// This function does not take any parameters or return any values. It simply hides the software keyboard when called.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    /// A utility function that hides the navigation bar.
    ///
    /// - Returns: A View with the navigation bar hidden.
    ///
    /// This function checks if the current iOS version is greater than or equal to iOS 16. If so, it returns the current view with the toolbar hidden using the toolbar modifier with a value of .hidden.
    ///
    /// If the iOS version is less than iOS 16, it returns the current view with an empty navigation bar title and the navigation bar hidden. This is achieved using the navigationBarTitle modifier with an empty string and the navigationBarHidden modifier with a value of true.
    ///
    /// This function does not take any parameters. It simply returns a modified View with the navigation bar hidden.
    func hideNav() -> some View {
        if #available(iOS 16, *) {
            return self.toolbar(.hidden)
        } else {
            return navigationBarTitle("", displayMode: .inline).navigationBarHidden(true)
        }
    }

    /// A view modifier that shows a double alert with a title, message, and an OK and Cancel button.
    ///
    /// Use this view modifier to present a double alert to the user. The alert has two buttons: OK and Cancel. When the user taps the OK button, the completion closure is called with a value of true, and the showAlert binding is set to false. When the user taps the Cancel button, the completion closure is called with a value of false, and the showAlert binding is set to false.
    ///
    /// Example usage:
    ///
    ///     struct ContentView: View {
    ///        @State var showAlert = false
    ///        @State var value = 0
    ///
    ///        var body: some View {
    ///            VStack {
    ///                Text("The value is \(value)")
    ///                Button("Increment") {
    ///                    showAlert = true
    ///                }
    ///            }
    ///            .doubleAlert(showAlert: $showAlert, value: $value, title: "Increment Value", message: "Are you sure you want to increment the value?", completion: { result in
    ///                if result {
    ///                    value += 1
    ///                }
    ///            })
    ///        }
    ///     }
    ///
    /// - Parameters:
    /// - showAlert: A binding to a Boolean value that controls whether to show the alert.
    /// - value: A binding to a Double value that is used to display and modify the value shown in the alert.
    /// - title: The title of the alert.
    /// - message: The message of the alert.
    /// - completion: A closure that is called when the user taps OK or Cancel. The closure is passed a Boolean value indicating whether the user tapped OK (true) or Cancel (false). The closure is called with a value of false when the user dismisses the alert without tapping a button. The default value is nil.
    ///
    /// - Returns: A view that shows a double alert.
    @available(iOS 15.0, *)
    func doubleAlert(showAlert: Binding<Bool>, value: Binding<Double>, title: String? = nil, message: String? = nil, completion: ((Bool) -> Void)? = nil) -> some View {
        modifier(DoubleAlertViewModifier(showAlert: showAlert, value: value, title: title, message: message, completion: completion))
    }

    /// A view modifier that shows a int alert with a title, message, and an OK and Cancel button.
    ///
    /// Use this view modifier to present a int alert to the user. The alert has two buttons: OK and Cancel. When the user taps the OK button, the completion closure is called with a value of true, and the showAlert binding is set to false. When the user taps the Cancel button, the completion closure is called with a value of false, and the showAlert binding is set to false.
    ///
    /// Example usage:
    ///
    ///     struct ContentView: View {
    ///        @State var showAlert = false
    ///        @State var value = 0
    ///
    ///        var body: some View {
    ///            VStack {
    ///                Text("The value is \(value)")
    ///                Button("Increment") {
    ///                    showAlert = true
    ///                }
    ///            }
    ///            .intAlert(showAlert: $showAlert, value: $value, title: "Increment Value", message: "Are you sure you want to increment the value?", completion: { result in
    ///                if result {
    ///                    value += 1
    ///                }
    ///            })
    ///        }
    ///     }
    ///
    /// - Parameters:
    /// - showAlert: A binding to a Boolean value that controls whether to show the alert.
    /// - value: A binding to a int value that is used to display and modify the value shown in the alert.
    /// - title: The title of the alert.
    /// - message: The message of the alert.
    /// - completion: A closure that is called when the user taps OK or Cancel. The closure is passed a Boolean value indicating whether the user tapped OK (true) or Cancel (false). The closure is called with a value of false when the user dismisses the alert without tapping a button. The default value is nil.
    ///
    /// - Returns: A view that shows a int alert.
    @available(iOS 15.0, *)
    func intAlert(showAlert: Binding<Bool>, value: Binding<Int>, title: String? = nil, message: String? = nil, completion: ((Bool) -> Void)? = nil) -> some View {
        modifier(IntAlertViewModifier(showAlert: showAlert, value: value, title: title, message: message, completion: completion))
    }

    /**
     A convenience function for applying the `TextFieldAlert` view modifier.

     Use this function to simplify the process of applying the `TextFieldAlert` view modifier to a view.

     The following example shows how to use the `textFieldAlert` function to edit a string value:

         struct ContentView: View {
             @State var name = "John"
             @State var showAlert = false

             var body: some View {
                 VStack {
                     Text("Hello, \(name)!")

                     Button("Edit Name") {
                         showAlert = true
                     }

                     // Apply the `textFieldAlert` function to the `Text` view to add an alert for editing the name.
                     Text(name)
                         .textFieldAlert(showAlert: $showAlert, text: $name, title: "Edit Name", textFieldPrompt: "Enter your name", completion: { success in
                             if success {
                                 print("Name saved successfully")
                             } else {
                                 print("Name edit cancelled")
                             }
                         }))
                 }
             }
         }

     - Parameters:
        - showAlert: A binding to a boolean that controls whether the alert is shown.
        - text: A binding to the string value to edit.
        - title: An optional title for the alert.
        - message: An optional message for the alert.
        - textFieldPrompt: An optional prompt for the text field.
        - completion: An optional completion handler that is called when the alert is dismissed. If the user clicks the "Submit" button, the completion handler is called with a `true` value. If the user clicks the "Cancel" button, the completion handler is called with a `false` value.

     - Returns: A view with the `TextFieldAlert` view modifier applied.
     */
    @available(iOS 15.0, *)
    func textFieldAlert(showAlert: Binding<Bool>, text: Binding<String>, title: String? = nil, message: String? = nil, textFieldPrompt: String? = nil, completion: ((Bool) -> Void)? = nil) -> some View {
        modifier(TextFieldAlert(showAlert: showAlert, text: text, title: title, message: message, textFieldPrompt: textFieldPrompt, completion: completion))
    }

    /**
      A view extension that applies the `PutInNavView` view modifier to a view.

      Use this extension to apply the `PutInNavView` to a view. The `displayMode` parameter determines the display mode of the navigation title.

     ``` Example:
      Text("Hello, World!")
         .putInNavView(.inline)

      */

    @available(iOS 14.0, *)
    func putInNavView(_ displayMode: NavigationBarItem.TitleDisplayMode) -> some View {
        modifier(PutInNavView(displayMode: displayMode))
    }

    /// A function that applies a `TabModifier` to a view, creating a tab item with a system image and the associated description.
    ///
    /// The function requires a type `T` that conforms to `RawRepresentable`, `Hashable`, and `CustomStringConvertible` protocols.
    /// The `RawValue` of the type `T` must be of type `String`.
    ///
    /// Usage:
    ///
    /// ```swift
    /// TabView {
    ///     Text("Tab 1")
    ///         .makeTab(tab: MyTabEnum.tab1, systemImage: "star.fill")
    ///     Text("Tab 2")
    ///         .makeTab(tab: MyTabEnum.tab2, systemImage: "heart.fill")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - tab: A value of type `T`, representing the current tab.
    ///   - systemImage: A `String` representing the system image to be used as the icon for the tab item.
    ///
    /// - Returns: A view with the tab item and tag applied using the `TabModifier`.
    ///
    @available(iOS 14.0, *)
    func makeTab<T: RawRepresentable>(tab: T, systemImage: String) -> some View where T.RawValue == String, T: Hashable, T: CustomStringConvertible {
        modifier(TabModifier(tab: tab, systemImage: systemImage))
    }

    /// Returns the view calling it as an AnyView type
    var anyView: AnyView {
        AnyView(self)
    }

    /// Applies the `PushTopModifier` to a view, aligning the content to the top of the available space.
    ///
    /// Use `pushTop(alignment:)` to align the content to the top of the available space,
    /// with the specified horizontal alignment, and push it to the top by adding a spacer below the content.
    ///
    /// Example usage:
    /// ```
    /// Text("Hello, World!")
    ///     .pushTop(alignment: .center)
    /// ```
    ///
    /// - Parameter alignment: The horizontal alignment for positioning the content within the available space.
    ///                        The default value is `.center`.
    /// - Returns: The modified content view with the `PushTopModifier` applied.
    func pushTop(alignment: HorizontalAlignment = .center) -> some View {
        modifier(PushTopModifier(alignment: alignment))
    }

    /// Applies horizontal and vertical padding to a view.
    ///
    /// Use padding(_ h: CGFloat, _ v: CGFloat) to apply horizontal and vertical padding to the view.
    ///
    /// - Parameters:
    /// - h: The horizontal padding to apply.
    /// - v: The vertical padding to apply.
    ///
    /// - Returns: The modified view.
    ///
    /// Example:
    ///
    /// Text("Hello, World!")
    /// .padding(10, 20)
    ///
    @available(iOS 13.0, *)
    func padding(_ h: CGFloat, _ v: CGFloat) -> some View {
        modifier(PaddingModifier(horizontal: h, vertical: v))
    }

    /// Conditionally applies the `searchable` modifier based on the given `isSearching` flag.
    ///
    /// If `isSearching` is set to `true`, the view will be made searchable. Otherwise, the view remains unmodified.
    ///
    /// - Parameters:
    ///   - isSearching: Indicates whether the content should be made searchable.
    ///   - searchText: A binding to the text that's being used for search.
    ///
    /// - Returns: A view that's either searchable or unmodified based on the `isSearching` flag.
    ///
    /// - Example Usage:
    ///
    /// ```
    /// VStack {
    ///     Text("Hello World")
    /// }
    /// .conditionallySearchable(isSearching: isCurrentlySearching, searchText: $currentSearchText)
    /// ```
    ///
    /// - Requires: iOS 15.0 and above.
    /// - SeeAlso: `SearchableIfSearching` for the underlying modifier.
    @available(iOS 15.0, *)
    func conditionallySearchable(isSearching: Bool, searchText: Binding<String>) -> some View {
        modifier(SearchableIfSearching(isSearching: isSearching, searchText: searchText))
    }

    /// Applies the `FadeEffectModifier` to a view with customizable parameters.
    ///
    /// This method extends `View` to include an easy way to apply the fading effect. You can customize the fade effect
    /// by providing values for the start and end opacities and points.
    ///
    /// - Parameters:
    ///   - startOpacity: The starting opacity of the fade effect. Defaults to `1` (fully opaque).
    ///   - endOpacity: The ending opacity of the fade effect. Defaults to `0` (fully transparent).
    ///   - startPoint: The starting point of the gradient used for the fade effect. Defaults to `.center`.
    ///   - endPoint: The ending point of the gradient used for the fade effect. Defaults to `.bottom`.
    /// - Returns: A view modified with the `FadeEffectModifier` using the specified parameters.
    ///
    /// - Availability: iOS 13.0+
    @available(iOS 13.0, *)
    func fadeEffect(startOpacity: Double = 1,
                    endOpacity: Double = 0,
                    startPoint: UnitPoint = .center,
                    endPoint: UnitPoint = .bottom)
        -> some View {
        modifier(
            FadeEffectModifier(startOpacity: startOpacity,
                               endOpacity: endOpacity,
                               startPoint: startPoint,
                               endPoint: endPoint)
        )
    }
}

/// Extension to apply various background styles to a `View`.
///
/// This extension adds methods to SwiftUI `View` to apply different types of background
/// layers with customization options for corner radius and safe area considerations.
///
/// - Requires: iOS 15.0 or later.
///
@available(iOS 15.0, *)
public extension View {
    /// Applies a layer background to the view with optional corner radius and safe area considerations.
    ///
    /// Use this method to add a customizable layer background to the view. You can specify the corner
    /// radius and whether the background should ignore safe areas.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius for the background. If `nil`, no corner radius is applied. Default is `nil`.
    ///   - ignores: A Boolean value that indicates whether the background should ignore safe area insets. Default is `false`.
    ///
    /// - Returns: A view modified with a layer background.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Text("Hello, World!")
    ///     .layerBackground(cornerRadius: 10, ignores: true)
    /// ```
    ///
    /// This example adds a layer background to the text with a 10-point corner radius and extends beyond the safe area.
    ///
    func layerBackground(cornerRadius: CGFloat? = nil,
                         ignores: Bool = false)
        -> some View {
        modifier(LayerBackgroundModifier(ignoresSafeAreas: ignores,
                                         cornerRadius: cornerRadius))
    }

    /// Applies a second-layer background to the view with optional corner radius and safe area considerations.
    ///
    /// Use this method to add a second layer of background to the view. You can specify the corner
    /// radius and whether the background should ignore safe areas.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius for the background. If `nil`, no corner radius is applied. Default is `nil`.
    ///   - ignores: A Boolean value that indicates whether the background should ignore safe area insets. Default is `false`.
    ///
    /// - Returns: A view modified with a second-layer background.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Text("Welcome")
    ///     .secondLayerBackground(cornerRadius: 8, ignores: true)
    /// ```
    ///
    /// In this example, the text view has a second-layer background with rounded corners of 8 points
    /// that extends beyond the safe area.
    ///
    func secondLayerBackground(cornerRadius: CGFloat? = nil,
                               ignores: Bool = false)
        -> some View {
        modifier(SecondLayerBackgroundModifier(ignoresSafeAreas: ignores,
                                               cornerRadius: cornerRadius))
    }

    /// Applies a primary background to the view with optional safe area considerations and corner radius.
    ///
    /// This method adds a primary background to the view. You can specify whether the background should
    /// ignore safe areas and the corner radius.
    ///
    /// - Parameters:
    ///   - ignores: A Boolean value indicating whether the background should ignore safe area insets. Default is `true`.
    ///   - cornerRadius: The corner radius for the background. If `nil`, no corner radius is applied. Default is `nil`.
    ///
    /// - Returns: A view modified with a primary background.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Text("Goodbye")
    ///     .mainBackground(ignores: false, cornerRadius: 5)
    /// ```
    ///
    /// This example adds a primary background to the text with a 5-point corner radius, contained within the safe area.
    ///
    func mainBackground(ignores: Bool = true,
                        cornerRadius: CGFloat? = nil)
        -> some View {
        modifier(MainBackgroundModifier(ignoresSafeAreas: ignores,
                                        cornerRadius: cornerRadius))
    }
}
