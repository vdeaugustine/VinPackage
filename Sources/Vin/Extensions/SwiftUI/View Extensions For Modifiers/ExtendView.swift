//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 11/20/23.
//

import Foundation
import SwiftUI


@available(iOS 13.0, *)
public extension View {
    
    /// Retrieves the frame of the view in the specified coordinate space and passes it to the callback.
    ///
    /// Use this method to get the frame of the view in a given coordinate space. The frame is passed to the provided callback closure.
    ///
    /// - Parameters:
    ///   - scope: The coordinate space in which to calculate the frame. Defaults to `.global`.
    ///   - callback: A closure that is called with the frame of the view as a `CGRect`.
    ///
    /// - Returns: A modified view that calculates and provides the frame to the callback.
    /// - Important: Requires **iOS 13.0** or later.
    func getFrame(in scope: CoordinateSpace = .global,
                  _ callback: @escaping (CGRect) -> Void)
        -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        callback(geometry.frame(in: scope))
                    }
            }
        )
    }
}
