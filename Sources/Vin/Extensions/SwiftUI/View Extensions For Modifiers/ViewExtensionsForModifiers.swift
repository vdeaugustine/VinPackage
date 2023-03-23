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
extension View {
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
    func allPartsTappable(alignment: Alignment? = nil) -> some View {
        ZStack(alignment: alignment ?? .center) {
            self
            Color.white
                .opacity(0.001)
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
}
