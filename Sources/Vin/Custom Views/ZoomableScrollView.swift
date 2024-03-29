//
//  SwiftUIView.swift
//  
//
//  Created by Vincent DeAugustine on 12/31/23.
//

import SwiftUI
import UIKit

// MARK: - ZoomableScrollView


/// A view that allows for pinching to zoom, and panning; features native to UIKit but not native to SwiftUI. It uses UIHostingController
@available(iOS 13.0, *)
public struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content

    /// A view that allows for pinching to zoom, and panning; features native to UIKit but not native to SwiftUI. It uses UIHostingController
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator // for viewForZooming(in:)
        scrollView.maximumZoomScale = 20
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true

        // create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)

        return scrollView
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: content))
    }

    public func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }

    // MARK: - Coordinator

    public class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>

        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }

        public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}


@available(iOS 13.0, *)
#Preview {
    ZoomableScrollView {
        
    }
}
