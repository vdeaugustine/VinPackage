//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 10/3/23.
//

import Foundation
import SwiftUI


@available(iOS 15.0, *)
public extension TextEditor {
    func placeholder(_ placeholder: String, text: Binding<String>) -> some View {
        modifier(StringPlaceholderModifier(text: text, placeholder: placeholder))
    }

    func placeholder<Placeholder: View>(text: Binding<String>, @ViewBuilder placeholder: () -> Placeholder) -> some View {
        modifier(ViewPlaceholderModifier(text: text, placeholder: placeholder()))
    }
}
