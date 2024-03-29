//
//  SwiftUIView.swift
//  
//
//  Created by Vincent DeAugustine on 5/7/23.
//

import SwiftUI

@available(iOS 13.0, *)
public struct SystemImageWithFilledBackground: View {
    let systemName: String
    let backgroundColor: Color
    var rotationDegrees: CGFloat = 0
    var gradient: LinearGradient?
    
    public init(systemName: String, backgroundColor: Color, rotationDegrees: CGFloat = 0, gradient: LinearGradient? = nil) {
        self.systemName = systemName
        self.backgroundColor = backgroundColor
        self.rotationDegrees = rotationDegrees
        self.gradient = gradient
    }
    
    public var body: some View {
        ZStack {
            if let gradient {
                gradient
            }
            Image(systemName: systemName)
                .font(.headline)
                .foregroundColor(.white)
                .rotationEffect(.degrees(rotationDegrees))
        }
        .frame(width: 28, height: 28)
        .cornerRadius(8)
    }
}

// MARK: - SystemImageWithFilledBackground_Previews

struct SystemImageWithFilledBackground_Previews: PreviewProvider {
    @available(iOS 13.0, *)
    static var previews: some View {
        SystemImageWithFilledBackground(systemName: "calendar", backgroundColor: .blue)
    }
}
