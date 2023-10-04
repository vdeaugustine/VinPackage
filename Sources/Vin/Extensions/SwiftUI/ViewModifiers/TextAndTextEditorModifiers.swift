//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 10/3/23.
//

import Foundation
import SwiftUI
// MARK: - StringPlaceholderModifier

@available(iOS 15.0, *)
public struct StringPlaceholderModifier: ViewModifier {
    @Binding var text: String
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                
//                    .font(.system(size: 16, weight: .regular, design: .default))
                    .padding(EdgeInsets(top: 9, leading: 4, bottom: 0, trailing: 0))
                    .opacity(0.5)
            }
            content
                .onTapGesture {
                    if text.isEmpty {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
        }
    }
}

// MARK: - ViewPlaceholderModifier
@available(iOS 15.0, *)
public struct ViewPlaceholderModifier<Placeholder: View>: ViewModifier {
    @Binding var text: String
    var placeholder: Placeholder

    public func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                placeholder
                    .padding(EdgeInsets(top: 9, leading: 4, bottom: 0, trailing: 0))
            }
            content
                .onTapGesture {
                    if text.isEmpty {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
        }
    }
}


