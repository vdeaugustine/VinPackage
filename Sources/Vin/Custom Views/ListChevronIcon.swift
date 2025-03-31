//
//  ListChevronIcon.swift
//  Vin
//
//  Created by Vincent DeAugustine on 3/30/25.
//

import SwiftUI

@available(iOS 16.0, *)
public struct ListChevronIcon: View {
    public var font: Font? = nil
    public var body: some View {
        Image(systemName: "chevron.right")
            .foregroundStyle(Color(.systemGray2))
            .font(font ?? .footnote)
            .fontWeight(.semibold)
    }
}
