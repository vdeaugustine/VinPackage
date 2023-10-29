//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 10/11/23.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
public extension View {
    /// A SwiftUI view modifier to add popover presentation functionality to the SwiftUI `View`.
    ///
    /// Utilizing this extension allows a popover to be presented, customized with the specified arrow directions, and contain SwiftUI `View` content.
    ///
    /// Example Usage:
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var isPopoverPresented = false
    ///
    ///     var body: some View {
    ///         Button("Show Popover") {
    ///             isPopoverPresented.toggle()
    ///         }
    ///         .floatingPopover(isPresented: $isPopoverPresented,
    ///                          arrowDirection: .up) {
    ///             Text("Hello, Popover!")
    ///         }
    ///     }
    /// }
    /// ```
    ///
    @ViewBuilder
    func floatingPopover<Content: View>(isPresented: Binding<Bool>,
                                        arrowDirection: UIPopoverArrowDirection,
                                        backgroundColor: Color? = nil,
                                        onDismiss: (() -> Void)? = nil,
                                        @ViewBuilder content: @escaping () -> Content)
        -> some View {
        background {
            FloatingPopOverController(isPresented: isPresented, arrowDirection: arrowDirection, backgroundColor: backgroundColor, onDismiss: onDismiss, content: content())
        }
    }
}

// MARK: - FloatingPopOverController

/// Popover Helper
///
/// `FloatingPopOverController` is a helper structure that wraps a SwiftUI view and presents it using UIKit's popover presentation mechanics.
///
/// It adheres to `UIViewControllerRepresentable` protocol to bridge between SwiftUI and UIKit, presenting SwiftUI views within UIKit's popover.
/// The presented content can be customized to update with SwiftUI state and interactions.
///
/// - Important: This component is fileprivate and designed to be used internally through `View` extensions.
///
@available(iOS 15.0, *)
struct FloatingPopOverController<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var arrowDirection: UIPopoverArrowDirection
    var backgroundColor: Color? = nil
    var onDismiss: (() -> Void)? = nil
    var content: Content

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        if let backgroundColor = backgroundColor?.uiColor {
            controller.view.backgroundColor = backgroundColor
        } else {
            controller.view.backgroundColor = .clear
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let hostingController = uiViewController.presentedViewController as? CustomHostingView<Content>{
            /// - Close View, if it's toggled Back
            if !isPresented {
                /// - Closing Popover
                uiViewController.dismiss(animated: true)
                onDismiss?()
            } else {
                hostingController.rootView = content
                /// - Updating View Size when it's Update
                /// - Or You can define your own size in SwiftUI View
                hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
                /// - If you don't want animation
                // UIView.animate(withDuration: 0) {
                //    hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
                // }
            }
        } else {
            if isPresented{
                /// - Presenting Popover
                let controller = CustomHostingView(rootView: content)
                controller.view.backgroundColor = .clear
                controller.modalPresentationStyle = .popover
                controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
                /// - Connecting Delegate
                controller.presentationController?.delegate = context.coordinator
                /// - We Need to Attach the Source View So that it will show Arrow At Correct Position
                controller.popoverPresentationController?.sourceView = uiViewController.view
                /// - Simply Presenting PopOver Controller
                uiViewController.present(controller, animated: true)
            }
        }
    }

    /// Forcing it to show Popover using PresentationDelegate
    ///
    /// `Coordinator` is a delegate adhering to `UIPopoverPresentationControllerDelegate`, ensuring to manage the presentation style and dismissal updates.
    ///
    /// It enforces the popover to always display as a popover (not adapting for compact size classes), and monitors the dismissal of the popover to update the SwiftUI state binding (`isPresented`).
    ///
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        var parent: FloatingPopOverController
        init(parent: FloatingPopOverController) {
            self.parent = parent
        }

        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }

        /// - Observing The status of the Popover
        /// - When it's dismissed updating the isPresented State
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
    }
}

// MARK: - CustomHostingView

/// Custom Hosting Controller for Wrapping to it's SwiftUI View Size
///
/// `CustomHostingView` is a specialized `UIHostingController` designed to adjust the preferred content size based on intrinsic content size, ensuring SwiftUI views size accurately within UIKit's hosting environment.
///
/// - Note: This class will adhere to the sizing behaviors of SwiftUI views and utilize the `intrinsicContentSize` to determine the `preferredContentSize` utilized by UIKit's popover presentation mechanics.
///
@available(iOS 15.0, *)

fileprivate class CustomHostingView<Content: View>: UIHostingController<Content>{
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = view.intrinsicContentSize
    }
}
